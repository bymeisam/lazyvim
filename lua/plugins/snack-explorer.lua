return {
  desc = "Snacks File Explorer",
  recommended = true,
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<leader>fe",
      function()
        Snacks.picker.explorer({
          cwd = LazyVim.root(),
          ignored = true,
          hidden = true,
          auto_close = true,
          layout = {
            preset = "default",
            preview = true,
          },
        })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function()
        Snacks.picker.explorer({
          cwd = vim.fn.expand("%:p:h"),
          ignored = true,
          hidden = true,
          auto_close = true,
          layout = {
            preset = "default",
            preview = true,
          },
        })
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
  },
}
