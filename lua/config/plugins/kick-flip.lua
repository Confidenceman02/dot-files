return {
	dir = "~/.config/nvim/lua/kick-flip",
	name = "kick-flip",
	init = function()
		vim.opt.clipboard = "unnamedplus"
	end,
	config = function()
		require("kick-flip").setup()
	end,
}
