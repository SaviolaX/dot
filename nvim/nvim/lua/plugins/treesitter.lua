return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
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
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    }
}
