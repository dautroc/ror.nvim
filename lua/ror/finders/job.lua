local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local jobs = vim.split(vim.fn.glob(root_path .. "/app/jobs/**/*rb"), "\n")
  local parsed_jobs = {}
  for _, value in ipairs(jobs) do
    if value ~= "" then
      local parsed_filename = vim.fn.fnamemodify(value, ":~:.")
      table.insert(parsed_jobs, parsed_filename)
    end
  end

  if #parsed_jobs > 0 then
    require("ror.picker").pick("Jobs", parsed_jobs)
  end
end

return M
