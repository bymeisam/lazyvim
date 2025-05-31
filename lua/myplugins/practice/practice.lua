local M = {}

function M.get_lines()
  local linesMap = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local lines = table.concat(linesMap, " ")
  -- local words = string.gmatch(lines, "%S+")
  local word_count = 0
  for _ in string.gmatch(lines, "%S+") do
    word_count = word_count + 1
  end

  print("There are " .. #linesMap .. " lines and" .. word_count .. " words in the buffer.")
end

return M
