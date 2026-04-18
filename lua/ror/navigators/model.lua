local utils = require("ror.navigators.utils")

local M = {}

local function navigate_from_controller(current_path, mode)
  local file_name = vim.fn.fnamemodify(current_path, ":t:r")
  local start, _ = string.find(file_name, "_controller")
  local model_name = string.sub(file_name, 1, start - 2)
  local parsed_model_name = "*" .. model_name .. ".rb"

  local models = utils.find_files("app/models", parsed_model_name)
  utils.open_or_pick("Models", models, mode, "No model with name: " .. model_name)
end

local function navigate_from_test(current_path, mode)
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
  local parsed_model_name = "*" .. model_name .. ".rb"

  local models = utils.find_files("app/models", parsed_model_name)
  utils.open_or_pick("Models", models, mode, "No model with name: " .. model_name)
end

function M.visit(mode)
  local current_path = vim.fn.expand("%:~:.")

  if string.match(current_path, "/controllers") then
    navigate_from_controller(current_path, mode)
  elseif string.match(current_path, "test/models") or string.match(current_path, "spec/models") then
    navigate_from_test(current_path, mode)
  end
end

return M
