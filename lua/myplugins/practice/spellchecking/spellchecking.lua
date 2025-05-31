local M = {}

function M.toggle_spell()
  local spell = not vim.wo.spell
  vim.wo.spell = spell
  print("Spell checking is " .. (spell and "enabled" or "disabled"))
end

return M
