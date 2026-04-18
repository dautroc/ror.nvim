local utils = require("ror.navigators.utils")

local M = {}

local function detect_test_framework()
  if M._framework then
    return M._framework
  end

  local root_path = vim.fn.getcwd()
  if vim.fn.isdirectory(root_path .. "/spec") == 1 then
    M._framework = { dir = "spec", suffix = "_spec" }
  else
    M._framework = { dir = "test", suffix = "_test" }
  end

  return M._framework
end

local function source_to_test(current_path, mode)
  local fw = detect_test_framework()

  local subpath, name
  local start, finish = string.find(current_path, "app/")
  if start then
    subpath = string.sub(current_path, finish + 1)
  else
    start, finish = string.find(current_path, "lib/")
    if start then
      subpath = string.sub(current_path, finish + 1)
    else
      return false
    end
  end

  name = vim.fn.fnamemodify(subpath, ":t:r")
  local dir_part = vim.fn.fnamemodify(subpath, ":h")
  local test_name = name .. fw.suffix .. ".rb"
  local search_dir = fw.dir .. "/" .. dir_part

  if vim.fn.isdirectory(search_dir) ~= 1 then
    return false
  end

  local files = utils.find_files(search_dir, test_name)
  utils.open_or_pick("Tests", files, mode, "No test found: " .. test_name)
  return true
end

local function test_to_source(current_path, mode)
  local fw = detect_test_framework()

  local prefix = fw.dir .. "/"
  local start, _ = string.find(current_path, prefix)
  if start ~= 1 then
    return false
  end

  local subpath = string.sub(current_path, #prefix + 1)
  local name = vim.fn.fnamemodify(subpath, ":t:r")
  local dir_part = vim.fn.fnamemodify(subpath, ":h")

  local source_name = string.gsub(name, fw.suffix .. "$", "")
  local source_file = source_name .. ".rb"
  local source_dir = "app/" .. dir_part

  local files = utils.find_files(source_dir, source_file)

  if #files == 0 and string.find(dir_part, "^lib/") then
    source_dir = dir_part
    files = utils.find_files(source_dir, source_file)
  elseif #files == 0 then
    files = utils.find_files("lib/" .. dir_part, source_file)
  end

  utils.open_or_pick("Source", files, mode, "No source file found: " .. source_file)
  return true
end

function M.visit(mode)
  local current_path = vim.fn.expand("%:~:.")
  local fw = detect_test_framework()

  if string.find(current_path, "^" .. fw.dir .. "/") then
    test_to_source(current_path, mode)
  else
    source_to_test(current_path, mode)
  end
end

function M.reset_framework_cache()
  M._framework = nil
end

return M
