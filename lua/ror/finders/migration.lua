local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local migrations = vim.split(vim.fn.glob(root_path .. "/db/migrate/*rb"), "\n")
  local parsed_migrations = {}
  for i = #migrations, 1, -1 do
    if migrations[i] ~= "" then
      local parsed_filename = vim.fn.fnamemodify(migrations[i], ":~:.")
      table.insert(parsed_migrations, parsed_filename)
    end
  end

  if #parsed_migrations > 0 then
    require("ror.picker").pick("DB Migrations", parsed_migrations)
  end
end

return M
