return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim",          config = true },
            { "williamboman/mason-lspconfig.nvim" },
            { "j-hui/fidget.nvim",                opts = {} },
            { "saghen/blink.cmp" },
        },
        config = function()
            require("mason").setup()
            local servers = {
                "lua_ls",
                "gopls",
                "pyright",
                "ts_ls",
                "bashls",
                "jsonls",
                "yamlls",
                "dockerls",
                "vue_ls",
            }
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })

            local vue_plugin_path = vim.fn.expand("$MASON/packages/vue-language-server")
                .. "/node_modules/@vue/language-server"

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vue_plugin_path,
                            languages = { "vue" },
                        },
                    },
                },
                filetypes = {
                    "typescript",
                    "javascript",
                    "javascriptreact",
                    "typescriptreact",
                    "vue",
                },
            })

            vim.lsp.config("vue_ls", {
                capabilities = capabilities,
                filetypes = { "vue" },
            })

            for _, s in ipairs(servers) do
                if s ~= "lua_ls" and s ~= "ts_ls" and s ~= "vue_ls" then
                    vim.lsp.config(s, { capabilities = capabilities })
                end
                vim.lsp.enable(s)
            end
        end,
    },
}
