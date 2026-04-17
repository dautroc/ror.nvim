local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local views = vim.split(vim.fn.glob(root_path .. "/app/views/**/*.erb"), "\n")
  local parsed_views = {}
  for _, view in ipairs(views) do
    if view ~= "" then
      local parsed_view = vim.fn.fnamemodify(view, ":~:.")
      table.insert(parsed_views, parsed_view)
    end
  end

  if #parsed_views > 0 then
    require("ror.picker").pick("Views", parsed_views)
  end
end

return M
