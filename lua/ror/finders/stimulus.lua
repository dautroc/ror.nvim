local M = {}

function M.find()
  local root_path = vim.fn.getcwd()
  local stimulus_controllers = vim.split(vim.fn.glob(root_path .. "/app/javascript/controllers/*js"), "\n")
  local parsed_stimulus_controllers = {}
  for _, stimulus_controller in ipairs(stimulus_controllers) do
    if stimulus_controller ~= "" then
      local parsed_stimulus_controller = vim.fn.fnamemodify(stimulus_controller, ":~:.")
      table.insert(parsed_stimulus_controllers, parsed_stimulus_controller)
    end
  end

  if #parsed_stimulus_controllers > 0 then
    require("ror.picker").pick("Stimulus controllers", parsed_stimulus_controllers)
  end
end

return M
