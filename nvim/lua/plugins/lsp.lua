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
            -- Mason UI + registry
            require("mason").setup()

            local servers = {
                "lua_ls",
                "gopls",
                "pyright",
                -- NOTE: mason renamed tsserver -> ts_ls in some setups.
                -- If "ts_ls" fails for you, change it to "tsserver" in both places.
                "ts_ls",
                "bashls",
                "jsonls",
                "yamlls",
                "dockerls",
            }

            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            -- LSP capabilities (for nvim-cmp)
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Buffer-local keymaps on LSP attach
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

            -- Extend/override per-server config using the new API.
            -- nvim-lspconfig provides the base configs via runtimepath `lsp/*.lua`.
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

            -- Generic defaults for the rest
            for _, s in ipairs(servers) do
                if s ~= "lua_ls" then
                    vim.lsp.config(s, {
                        capabilities = capabilities,
                    })
                end
                vim.lsp.enable(s)
            end
        end,
    },
}
