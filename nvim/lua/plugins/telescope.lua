return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				initial_mode = "normal", -- open telescope in normal mode
			},
		})
		vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files)
	end,
}
