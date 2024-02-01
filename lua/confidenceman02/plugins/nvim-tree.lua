return {
	dir = "~/code/nvim-tree.lua/",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded = 1
		vim.g.loaded_netrwPlugin = 1

		-- change color for arrows in tree to light blue
		vim.cmd([[highlight NvimTreeIndentMarker guifg=#3FC5FF]])

		nvimtree.setup({
			view = {
				width = 60,
			},
			-- change folder arrow icons
			renderer = {
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "🡪", -- arrow when folder is closed
							arrow_open = "🡫", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- exporer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>") -- toggle file explorer
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>") -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>") -- refresh file explorer
	end,
}
