local wezterm = require("wezterm")
return {
	window_close_confirmation = "NeverPrompt",
	color_scheme = "Gruvbox dark, hard (base16)",
	--	font = wezterm.font("UbuntuMono Nerd Font"),
	font_size = 18,
	colors = {
		cursor_bg = "#928374",
		cursor_border = "#928374",
	},
	term = "xterm-256color",
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
}
