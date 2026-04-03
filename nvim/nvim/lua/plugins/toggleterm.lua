return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            size = function()
                return math.floor(vim.o.lines * 0.8)
            end,
            open_mapping = [[<C-_>]],
            hide_numbers = true,
            shade_terminals = false,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            direction = "float",

            float_opts = {
                border = "rounded",
                width = function()
                    return math.floor(vim.o.columns * 0.8)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.8)
                end,
            },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)

            -- Better terminal escape
            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
        end,
    },
}
