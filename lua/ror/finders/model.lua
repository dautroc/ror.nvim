local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local models = vim.split(vim.fn.glob(root_path .. "/app/models/**/*rb"), "\n")
  local parsed_models = {}
  for _, value in ipairs(models) do
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_models, parsed_filename)
    end
  end

  if #parsed_models > 0 then
    require("ror.picker").pick("Models", parsed_models)
  end
end

return M
