-- A simple module to handle our clipboard pipe
local M = {}

-- TODO Resolve name from config
local pipe_dir = "/clipboard_pipe"
local clipboard_pipe = pipe_dir .. "/clipboard_pipe/nvim_clipboard"

M.has_start = function()
	local start_file = pipe_dir .. "/kick-flip.start"
	local stat = vim.uv.fs_stat(start_file)
	return stat ~= nil
end

M.set_clipboard = function(text)
	if type(text) == "table" then
		text = vim.fn.join(text, "\n")
	end

	local file = io.open(clipboard_pipe, "w")
	if file and M.has_start() then
		file:write(text)
		file:close()
	end
end

M.get_clipboard = function()
	local content = vim.fn.getreg('"')

	if content and #content > 0 then
		return vim.split(content, "\n", { plain = true })
	end
	return {}
end

function M.setup()
	vim.g.clipboard = {
		name = "KICK-FLIP",
		copy = {
			["+"] = M.set_clipboard,
			["*"] = M.set_clipboard,
		},
		paste = {
			["+"] = M.get_clipboard,
			["*"] = M.get_clipboard,
		},
	}
end

return M
