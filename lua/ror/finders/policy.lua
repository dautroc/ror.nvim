local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local policies = vim.split(vim.fn.glob(root_path .. "/app/policies/**/*rb"), "\n")
  local parsed_policies = {}
  for _, value in ipairs(policies) do
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_policies, parsed_filename)
    end
  end

  if #parsed_policies > 0 then
    require("ror.picker").pick("Policies", parsed_policies)
  end
end

return M
