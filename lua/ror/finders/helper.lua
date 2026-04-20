local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local helpers = vim.split(vim.fn.glob(root_path .. "/app/helpers/**/*rb"), "\n")
  local parsed_helpers = {}
  for _, value in ipairs(helpers) do
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_helpers, parsed_filename)
    end
  end

  if #parsed_helpers > 0 then
    require("ror.picker").pick("Helpers", parsed_helpers)
  end
end

return M
