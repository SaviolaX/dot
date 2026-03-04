return {
    {
        "saghen/blink.cmp",
        lazy = false,
        version = "*",
        opts = {
            keymap = {
                preset = "none",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-space>"] = { "show", "fallback" },
                ["<C-e>"] = { "cancel", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                menu = {
                    auto_show = true,
                },
            },
        },
    }
}
