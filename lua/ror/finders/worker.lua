local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local workers = vim.split(vim.fn.glob(root_path .. "/app/workers/**/*rb"), "\n")
  local parsed_workers = {}
  for _, value in ipairs(workers) do
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_workers, parsed_filename)
    end
  end

  if #parsed_workers > 0 then
    require("ror.picker").pick("Workers", parsed_workers)
  end
end

return M
