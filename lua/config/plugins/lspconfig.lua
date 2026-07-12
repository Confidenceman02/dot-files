return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local keymap = vim.keymap -- for conciseness
		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.lsp.config("elmls", {
			capabilities = capabilities,
			on_attach = on_attach,

			settings = {
				elmLS = {
					elmPath = "/usr/local/bin/elm",
				},
			},
		})

		vim.lsp.config("ruff", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.config("pyright", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = function(bufnr, on_dir)
				local filename = vim.api.nvim_buf_get_name(bufnr)
				if filename == "" then
					return
				end

				-- Resolve symlinks to bypass virtual pnpm store pathways cleanly
				local real_path = vim.fs.normalize(vim.loop.fs_realpath(filename) or filename)

				-- Search upward from the real file location for monorepo anchors
				local root = vim.fs.find(
					{ "pnpm-workspace.yaml", "pnpm-lock.yaml", "package.json" },
					{ path = real_path, upward = true }
				)[1]

				-- Compute the final workspace boundary
				local final_root = root and vim.fs.dirname(root) or "/app"

				-- Trigger the native 0.11 async callback engine
				on_dir(final_root)
			end,
			init_options = {
				tsserver = {
					path = "/app/node_modules/.pnpm/typescript@7.0.2/node_modules/typescript/lib",
				},
			},
		})

		vim.lsp.enable("ts_ls")
		vim.lsp.enable("elmls")
	end,
}
