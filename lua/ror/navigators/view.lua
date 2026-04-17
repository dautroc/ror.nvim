local M = {}

function M.visit()
  local root_path = vim.fn.getcwd()
  local current_relative_file_path = vim.fn.expand("%:~:.")

  if string.match(current_relative_file_path, "app/models") then
    local model_name = vim.fn.fnamemodify(current_relative_file_path, ":t:r")
    local view_directory = root_path .. "/app/views/" .. model_name .. "s" .."/**/*.html.erb"

    local views = vim.split(vim.fn.glob(view_directory), "\n")
    local parsed_views = {}
    for _, view in pairs(views) do
      if view ~= "" then
        local parsed_view = vim.fn.fnamemodify(view, ":~:.")
        table.insert(parsed_views, parsed_view)
      end
    end

    if #parsed_views > 0 then
      require("ror.picker").pick("Views", parsed_views)
    else
      local nvim_notify_ok, nvim_notify = pcall(require, 'notify')
      if nvim_notify_ok then
        nvim_notify(
          "No view for model: " .. model_name,
          vim.log.levels.ERROR,
          { title = "View file not found", timeout = 2500 }
        )
      else
        vim.notify("View file not found")
      end
    end
  elseif string.match(current_relative_file_path, "app/controllers") then
    local controller_name = vim.fn.fnamemodify(current_relative_file_path, ":t:r")
    local start, _ = string.find(controller_name, "_controller")
    controller_name = string.sub(controller_name, 1, start - 1)
    local view_directory = root_path .. "/app/views/" .. controller_name .."/**/*.html.erb"

    local views = vim.split(vim.fn.glob(view_directory), "\n")
    local parsed_views = {}
    for _, view in pairs(views) do
      if view ~= "" then
        local parsed_view = vim.fn.fnamemodify(view, ":~:.")
        table.insert(parsed_views, parsed_view)
      end
    end

    if #parsed_views > 0 then
      require("ror.picker").pick("Views", parsed_views)
    else
      local nvim_notify_ok, nvim_notify = pcall(require, 'notify')
      if nvim_notify_ok then
        nvim_notify(
          "No views for controller: " .. controller_name,
          vim.log.levels.ERROR,
          { title = "View file not found", timeout = 2500 }
        )
      else
        vim.notify("View file not found")
      end
    end
  end
end

return M
