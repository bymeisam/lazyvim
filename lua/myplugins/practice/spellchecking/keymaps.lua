vim.api.nvim_create_user_command("ToggleSpell", function()
  require("myplugins.spellchecking.spellchecking").toggle_spell()
end, {})

vim.keymap.set("n", "<leader>ms", ":ToggleSpell<CR>", { noremap = true, silent = true })
