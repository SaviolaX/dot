return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- disable netrw (recommended)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.opt.termguicolors = true

        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#1d2021" })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#1d2021" })
        vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "#1d2021" })

        vim.api.nvim_set_hl(0, "NvimTreeCursorLine", {
            bg = "#3c3836",
            bold = true,
        })

        require("nvim-tree").setup({
            sort_by = "case_sensitive",

            view = {
                width = 30,
                side = "left",
            },

            renderer = {
                group_empty = true,
            },

            filters = {
                dotfiles = false,
            },

            git = {
                ignore = false,
            },

            actions = {
                open_file = {
                    quit_on_open = false,
                },
            },
        })

        -- keymaps
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
        vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", { silent = true })
        vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
        vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })
    end,
}
