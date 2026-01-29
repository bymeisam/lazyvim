-- Create or edit: ~/.config/nvim/lua/plugins/noice.lua

return {
  "folke/noice.nvim",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "50%", -- Vertical center (50% of screen height)
          col = "50%", -- Horizontal center
        },
        size = {
          min_width = 60, -- Reasonable minimum width
          width = "auto",
          height = "auto",
        },
        border = {
          style = "rounded", -- Or "single", "double", "none" — your preference
          -- padding = { top = 1, bottom = 1, left = 2, right = 2 },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "NoiceCmdlinePopupBorder",
          },
        },
      },
    },
    -- Optional: Keep other useful parts (messages, notify, etc.)
    presets = {
      bottom_search = true, -- Keeps search (/) at bottom if you prefer
      command_palette = false, -- Avoids large centered palette overriding cmdline
      long_message_to_split = true,
    },
  },
}
