local vllm_host = os.getenv("DUMBO_VLLM_HOST") or "vllm-local-coder:8026"

return {
	"Confidenceman02/dumbo",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.api.nvim_set_hl(0, "DumboGhostText", { fg = "#6c7086", italic = true, default = true })

		local dumbo = require("dumbo")
		dumbo.setup({
			debounce_ms = 200,
			client = {
				endpoint = "http://" .. vllm_host .. "/v1/completions",
				model = "Qwen/Qwen2.5-Coder-7B-Instruct-AWQ",
			},
			payload = {
				max_tokens = 48,
				temperature = 0.0,
			},
		})

		-- Map <Tab> to accept ghost text if present
		vim.keymap.set("i", "<Tab>", function()
			if not dumbo.accept() then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
			end
		end, { silent = true, desc = "Accept Dumbo completion" })

		-- Map <C-]> to dismiss suggestion
		vim.keymap.set("i", "<C-]>", function()
			dumbo.dismiss()
		end, { silent = true, desc = "Dismiss Dumbo suggestion" })
	end,
}
