vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.blade.php",
  command = "set filetype=html",
})
