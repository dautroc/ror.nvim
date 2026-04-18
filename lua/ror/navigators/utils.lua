local M = {}

function M.find_files(search_dir, file_pattern)
  local results = vim.split(vim.fn.system({ "find", search_dir, "-name", file_pattern }), "\n")
  local parsed = {}
  for _, item in pairs(results) do
    if item ~= "" then
      table.insert(parsed, item)
    end
  end
  return parsed
end

function M.strip_test_suffix(name)
  for _, suffix in ipairs({ "_test", "_spec" }) do
    local start, _ = string.find(name, suffix)
    if start ~= nil then
      return string.sub(name, 1, start - 1)
    end
  end
  return name
end

function M.open_or_pick(title, files, mode, not_found_message)
  if #files > 1 then
    require("ror.picker").pick(title, files)
  elseif #files == 1 then
    if mode == "normal" then
      vim.cmd.edit(files[1])
    elseif mode == "vsplit" then
      vim.cmd.vsplit(files[1])
    end
  else
    local nvim_notify_ok, nvim_notify = pcall(require, 'notify')
    if nvim_notify_ok then
      nvim_notify(
        not_found_message,
        vim.log.levels.ERROR,
        { title = "File not found", timeout = 2500 }
      )
    else
      vim.notify(not_found_message, vim.log.levels.ERROR)
    end
  end
end

return M
