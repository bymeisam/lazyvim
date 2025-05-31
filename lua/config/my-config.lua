local keymap = vim.keymap.set

--{ "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
keymap("n", "<leader>m", "", { desc = "my config" })
keymap(
  "n",
  "<leader>mgc",
  LazyVim.pick("live_grep", { cwd = "~/.local/share/nvim/", ignored = true, hidden = true }),
  { desc = "search nvim config" }
)
keymap("n", "<leader>bl", function()
  Snacks.picker.buffers()
end, { desc = "move to next error" })

-- TODO: fix this

keymap("n", "]e", vim.diagnostic.goto_next, { desc = "move to next error" })
-- Toggle LSP inlay hints
vim.keymap.set("n", "<leader>ti", function()
  local current_state = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not current_state)
  print("Inlay hints " .. (not current_state and "enabled" or "disabled"))
end, { desc = "Toggle Inlay Hints" })
