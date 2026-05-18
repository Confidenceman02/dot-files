return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",   -- Forces the stable branch that works perfectly on startup
    build = ":TSUpdate", -- Overrides LazyVim's line 12 function with a safe string command
  },
}
