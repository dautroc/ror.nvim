local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local mailers = vim.split(vim.fn.glob(root_path .. "/app/mailers/**/*rb"), "\n")
  local parsed_mailers = {}
  for _, value in ipairs(mailers) do
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_mailers, parsed_filename)
    end
  end

  if #parsed_mailers > 0 then
    require("ror.picker").pick("Mailers", parsed_mailers)
  end
end

return M
