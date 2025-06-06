return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opt = {} },
		"neovim/neovim-lspconfig",
	},
	config = function()
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers you want mason to install
			ensure_installed = {
				"elmls",
				"ts_ls",
				"ruff",
				"tailwindcss",
				"lua_ls",
				"pyright",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true,
		})
	end,
}
