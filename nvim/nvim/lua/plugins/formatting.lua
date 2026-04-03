return {
    -- =========================
    -- Formatters (format-on-save)
    -- =========================
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        opts = {
            format_on_save = function(_bufnr)
                return { timeout_ms = 2000, lsp_fallback = true }
            end,

            formatters_by_ft = {
                -- Core
                lua = { "stylua" },
                go = { "gofmt" },           -- or "goimports"
                python = { "ruff_format" }, -- or "black" if you prefer
                sh = { "shfmt" },

                -- Web
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                vue = { "prettier" },

                -- Data formats
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" }, -- or "yamlfmt"
                toml = { "taplo" },

                -- Docs
                markdown = { "prettier" },

                -- DevOps
                dockerfile = { "dockfmt" },
                terraform = { "terraform_fmt" },

                -- SQL
                sql = { "sqlfluff" },
                postgres = { "sqlfluff" },
            },
        },

        config = function(_, opts)
            require("conform").setup(opts)

            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({
                    async = true,
                    lsp_fallback = true,
                })
            end, { desc = "Format buffer" })
        end,
    },

    -- =========================
    -- Linters
    -- =========================
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                python = { "ruff" },
                sh = { "shellcheck" },
                sql = { "sqlfluff" },
                dockerfile = { "hadolint" },
                vue = { "eslint_d" },
            }

            local grp = vim.api.nvim_create_augroup("linting", { clear = true })

            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                group = grp,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>l", function()
                lint.try_lint()
            end, { desc = "Lint buffer" })
        end,
    },

    -- =========================
    -- Install external tools via Mason automatically
    -- =========================
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- formatters
                    "stylua",
                    "prettier",
                    "shfmt",
                    "ruff",
                    "black",
                    "taplo",
                    "dockfmt",
                    "terraform_fmt",
                    "sqlfluff",

                    -- linters
                    "shellcheck",
                    "eslint_d",
                    "hadolint",
                },
                run_on_start = true,
            })
        end,
    },
}
