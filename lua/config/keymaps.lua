-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap.set
-- Go back with 'gb'
keymap("n", "gb", "<C-o>", { desc = "Go back" })

-- G to Gzz (center cursor after going to bottom)
keymap("n", "G", ":normal! Gzz<CR>", { noremap = true, silent = true, desc = "Go to bottom and center" })

-- Center cursor when moving up/down
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
keymap("n", "n", "nzz", { desc = "Next search result and center" })
keymap("n", "N", "Nzz", { desc = "Previous search result and center" })

-- Better line movement
keymap("n", "j", "gj", { desc = "Move down by visual line" })
keymap("n", "k", "gk", { desc = "Move up by visual line" })

-- Move lines up and down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep paste buffer when replacing text
keymap("x", "<leader>p", '"_dP', { desc = "Paste without yank" })

-- Telescope search with visual mode support
keymap({ "n", "v" }, "<leader>sg", function()
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    vim.cmd('normal! "zy') -- Yank to z register
    require("telescope.builtin").live_grep({ default_text = vim.fn.getreg("z") })
  else
    require("telescope.builtin").live_grep() -- Normal mode: empty prompt
  end
end, { desc = "Grep root dir" })
