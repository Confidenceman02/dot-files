-- =====================================================================
-- Elm Auto-Format on Save (Direct Binary Bypass)
-- =====================================================================
local elm_format_group = vim.api.nvim_create_augroup("ElmLspFormat", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = elm_format_group,
	pattern = "*.elm",
	callback = function()
		-- Capture the current file path
		vim.lsp.buf.format({
			async = false,
			-- Force it to use elmls just in case other engines try to bind to it
			name = "elmls",
		})
	end,
})
