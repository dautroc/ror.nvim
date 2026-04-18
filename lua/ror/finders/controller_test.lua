local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local test_files = vim.split(vim.fn.glob(root_path .. "/test/controllers/**/*rb"), "\n")
  local spec_files = vim.split(vim.fn.glob(root_path .. "/spec/controllers/**/*rb"), "\n")
  local parsed_tests = {}
  for _, test in ipairs(test_files) do
    if test ~= "" then
      table.insert(parsed_tests, vim.fn.fnamemodify(test, ":~:."))
    end
  end
  for _, test in ipairs(spec_files) do
    if test ~= "" then
      table.insert(parsed_tests, vim.fn.fnamemodify(test, ":~:."))
    end
  end

  if #parsed_tests > 0 then
    require("ror.picker").pick("Controller tests", parsed_tests)
  end
end

return M
