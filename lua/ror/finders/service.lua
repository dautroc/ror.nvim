local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local services = vim.split(vim.fn.glob(root_path .. "/app/services/**/*rb"), "\n")
  local parsed_services = {}
  for _, value in ipairs(services) do
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_services, parsed_filename)
    end
  end

  if #parsed_services > 0 then
    require("ror.picker").pick("Services", parsed_services)
  end
end

return M
