local M = {}

M.cursorline_tracking_enabled = true

local group = nil
function M.toggle_cursorline_tracker_byevent()
  group = vim.api.nvim_create_augroup("cursorline_tracker", { clear = true })
  vim.api.nvim.create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    callback = function()
      vim.wo.cursorline = true
      print("Cursorline enabled")
    end,
  })

  vim.api.nvim.create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    callback = function()
      vim.wo.cursorline = false
      print("Cursorline disabled")
    end,
  })
end

vim.api.nvim_create_user_command("ToggleCursorLine", function()
  if M.cursorline_tracking_enabled then
    -- vim.api.nvim.del_augroup("cursorline_tracker")
    if group then
      vim.api.nvim_del_augroup_by_id(group)
      vim.api.nvim_del_augroup_by_name(group)
    end
    M.cursorline_tracking_enabled = false
  else
    M.toggle_cursorline_tracker_byevent()
    M.cursorline_tracking_enabled = true
  end
end, { desc = "Toggle cursor line tracking" })
return M
