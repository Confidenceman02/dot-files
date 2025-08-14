return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
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
				"elm-language-server",
				"ts_ls",
				"lua_ls",
				"pyright",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true,
		})
	end,
}
