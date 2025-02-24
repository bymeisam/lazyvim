return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x", -- Stable branch as of Feb 2025
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required dependency
    },
    keys = {
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep root dir" },
      { "<leader>sG", "<cmd>Telescope live_grep cwd=vim.fn.getcwd()<cr>", desc = "Grep cwd" },
    },
    opts = {
      defaults = {
        -- Optional: Customize Telescope behavior
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
      },
    },
  },
}
