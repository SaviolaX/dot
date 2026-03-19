return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "json", "javascript", "typescript", "tsx",
                    "go", "yaml", "html", "css", "python",
                    "markdown", "markdown_inline", "bash", "lua",
                    "vim", "dockerfile", "gitignore", "query",
                    "vimdoc", "c", "java", "rust",
                },
                auto_install = true,
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                        },
                    },
                },
            })

            vim.keymap.set("n", "<leader>sf", "vaf", { desc = "Select function" })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    }
}
