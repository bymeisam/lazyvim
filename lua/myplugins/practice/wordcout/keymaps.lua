vim.api.nvim_create_user_command("SWordCount", function()
  require("myplugins.wordcout.wordcount").wordcount()
end, {})

vim.keymap.set("n", "<leader>wc", ":SWordCount<CR>", { noremap = true, silent = false })
