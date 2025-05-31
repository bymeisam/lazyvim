local M = {}

function M.wraptoggle()
  local wrapStatus = vim.wo.wrap
  vim.wo.wrap = not wrapStatus

  print(not wrapStatus and "Wrap is now OFF" or "Wrap is now ON")
end

return M
