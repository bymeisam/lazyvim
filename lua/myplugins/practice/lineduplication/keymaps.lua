vim.api.nvim_create_user_command("DuplicateLine", function()
  require("myplugins.practice.lineduplication.lineduplication").duplicateLine()
end, {})

vim.keymap.set("n", "<leader>md", ":DuplicateLine<CR>", { noremap = true, silent = true })
