local utils = require("ror.navigators.utils")

local M = {}

local function navigate_from_model(current_path, mode)
  local model_name = vim.fn.fnamemodify(current_path, ":t:r")
  local start, _ = string.find(model_name, "_test")
  if start ~= nil then
    model_name = string.sub(model_name, 1, start - 1)
  else
    start, _ = string.find(model_name, "_spec")
    if start ~= nil then
      model_name = string.sub(model_name, 1, start - 1)
    end
  end
  local parsed_controller_name = "*" .. model_name .. "s_controller.rb"

  local controllers = utils.find_files("app/controllers", parsed_controller_name)
  utils.open_or_pick("Controllers", controllers, mode, "No controller with name: " .. parsed_controller_name)
end

local function navigate_from_test(current_path, mode)
  local controller_name = vim.fn.fnamemodify(current_path, ":t:r")
  local start, _ = string.find(controller_name, "_test")
  if start ~= nil then
    controller_name = string.sub(controller_name, 1, start - 1)
  else
    start, _ = string.find(controller_name, "_spec")
    if start ~= nil then
      controller_name = string.sub(controller_name, 1, start - 1)
    end
  end
  local parsed_controller_name = "*" .. controller_name .. ".rb"

  local controllers = utils.find_files("app/controllers", parsed_controller_name)
  utils.open_or_pick("Controllers", controllers, mode, "No controller with name: " .. parsed_controller_name)
end

function M.visit(mode)
  local current_path = vim.fn.expand("%:~:.")

  if string.match(current_path, "/models") then
    navigate_from_model(current_path, mode)
  elseif string.match(current_path, "test/controllers") or string.match(current_path, "spec/controllers") then
    navigate_from_test(current_path, mode)
  end
end

return M
