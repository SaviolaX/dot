return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip", -- LuaSnip source for nvim-cmp
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
			"hrsh7th/cmp-path", -- Path source for nvim-cmp
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				-- Enable snippet support
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				-- Keymappings (similar to your blink.cmp setup)
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
					-- Optional: Add Tab for snippet jumping and completion
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				-- Sources for autocompletion
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP completions
					{ name = "luasnip" }, -- Snippet completions
					{ name = "buffer" }, -- Buffer words
					{ name = "path" }, -- File paths
				}),
				experimental = {
					ghost_text = true, -- Show inline preview of completion
				},
			})
		end,
	},
	-- {
	-- 	"saghen/blink.cmp",
	-- 	dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },

	-- 	version = "1.*",
	-- 	opts = {
	-- 		keymap = {
	-- 			preset = "enter",
	-- 			["<C-k>"] = { "select_prev", "fallback" },
	-- 			["<C-j>"] = { "select_next", "fallback" },
	-- 		},
	-- 		appearance = {
	-- 			use_nvim_cmp_as_default = true,
	-- 			nerd_font_variant = "mono",
	-- 		},

	-- 		signature = { enabled = true },
	-- 		snippet = {
	-- 			enabled = true,
	-- 			backend = "luasnip",
	-- 		},
	-- 		windows = {
	-- 			ghost_text = {
	-- 				enabled = false,
	-- 			},
	-- 		},
	-- 	},
	-- },
}
