local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local tests = vim.split(vim.fn.glob(root_path .. "/test/models/**/*rb"), "\n")
  local parsed_tests = {}
  for _, test in ipairs(tests) do
    if test ~= "" then
      local parsed_test = vim.fn.fnamemodify(test, ":~:.")
      table.insert(parsed_tests, parsed_test)
    end
  end

  if #parsed_tests > 0 then
    require("ror.picker").pick("Model tests", parsed_tests)
  end
end

return M
