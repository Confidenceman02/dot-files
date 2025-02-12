return {
	"bluz71/vim-nightfly-guicolors",
	priority = 1000,
	config = function()
		--load colorsheme here
		vim.cmd([[colorscheme nightfly]])
		vim.cmd("highlight clear Comment")
	end,
}
