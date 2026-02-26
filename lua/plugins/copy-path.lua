-- Copy buffer path utilities
return {
  {
    "copy-path",
    dir = vim.fn.stdpath("config"),
    name = "copy-path",
    lazy = false,
    keys = {
      {
        "<leader>fy",
        function()
          local path = vim.fn.expand("%:.")
          vim.fn.setreg("+", path)
          vim.notify("Copied: " .. path, vim.log.levels.INFO)
        end,
        desc = "Copy relative path",
      },
      {
        "<leader>fY",
        function()
          local path = vim.fn.expand("%:p")
          vim.fn.setreg("+", path)
          vim.notify("Copied: " .. path, vim.log.levels.INFO)
        end,
        desc = "Copy absolute path",
      },
    },
  },
}
