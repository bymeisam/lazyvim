local M = {}

function M.wordcount()
  local wordUnderCursor = vim.fn.expand("<cword>")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local allLines = table.concat(lines, " ")
  local wordCount = 0

  -- for i in allLines:gmatch("%S+") do
  --   if string.find(i, wordUnderCursor) then
  --     wordCount = wordCount + 1
  --   end
  -- end

  -- Use frontier pattern to match exact whole words
  local pattern = "%f[%w]" .. wordUnderCursor .. "%f[%W]"
  for _ in allLines:gmatch(pattern) do
    wordCount = wordCount + 1
    print(_)
  end
  print("The word '" .. wordUnderCursor .. "' appears " .. wordCount .. " times in the current buffer.")
end
return M
