local wezterm = require("wezterm")
return {
    window_close_confirmation = 'NeverPrompt',

    -- Gruvbox Dark (deeper terxt color)
    colors = {
        foreground = "#F2E5BC",
        background = "#1D2021",

        cursor_bg = "#928374",
        cursor_border = "#928374",
        cursor_fg = "#1D2021",

        selection_bg = "#F2E5BC",
        selection_fg = "#3C3836",

        ansi = {
            "#32302F",
            "#CC241D",
            "#98971A",
            "#D79921",
            "#458588",
            "#B16286",
            "#689D6A",
            "#928374",
        },

        brights = {
            "#1D2021",
            "#FB4934",
            "#B8BB26",
            "#FABD2F",
            "#83A598",
            "#D3869B",
            "#8EC07C",
            "#B9A693",
        },
    },

    font = wezterm.font('JetBrains Mono', { weight = 'Bold', italic = false }),
    font_size = 14,
    term = "xterm-256color",

    --  window_decorations = "RESIZE",
    hide_tab_bar_if_only_one_tab = true,
    window_padding = {
        left = 20,
        right = 20,
        top = 25,
        bottom = 25,
    },
    initial_cols = 130,
    initial_rows = 35,
}
