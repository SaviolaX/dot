return {
	{
		"williamboman/mason.nvim",
		version = "^1.0.0",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.0.0",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "gopls", "bashls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Apply capabilities to all LSP servers
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Recognize 'vim' global for Neovim config
						},
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
		end,
		--	config = function()
		--		local lspconfig = require("lspconfig")
		--		-- local capabilities = require("blink.cmp").get_lsp_capabilities()
		--		lspconfig.lua_ls.setup({
		--			-- capabilities = capabilities,
		--		})
		--		lspconfig.pyright.setup({
		--			-- capabilities = capabilities,
		--		})
		--		lspconfig.ts_ls.setup({
		--			-- capabilities = capabilities,
		--		})
		--		lspconfig.gopls.setup({
		--			-- capabilities = capabilities,
		--		})
		--		lspconfig.bashls.setup({
		--			-- capabilities = capabilities,
		--		})
		--		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		--		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		--	end,
	},
}
