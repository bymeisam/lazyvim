local M = {}

function M.requireWithBaseUrl(baseUrl)
  return function(moduleName)
    local modulePath = baseUrl .. "." .. moduleName
    local success, result = pcall(require, modulePath)
    if not success then
      print("Couldnt load " .. modulePath .. ": " .. result)
    end
    return result
  end
end

return M
