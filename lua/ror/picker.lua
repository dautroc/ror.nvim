local M = {}

function M.pick(title, results)
  local config = require("ror.config")
  local picker_backend = config.values.picker or "telescope"

  if picker_backend == "snacks" then
    local ok, snacks = pcall(function()
      return Snacks.picker
    end)
    if ok and snacks then
      local items = {}
      for _, path in ipairs(results) do
        table.insert(items, { text = path, file = path })
      end
      snacks.pick({
        items = items,
        title = title,
      })
      return
    else
      vim.notify("snacks.picker not available, falling back to vim.ui.select", vim.log.levels.WARN)
    end
  elseif picker_backend == "telescope" then
    local ok, _ = pcall(require, "telescope")
    if ok then
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local previewers = require("telescope.previewers")
      local conf = require("telescope.config").values
      local opts = {}
      pickers.new(opts, {
        prompt_title = title,
        finder = finders.new_table { results = results },
        previewer = previewers.vim_buffer_cat.new(opts),
        sorter = conf.generic_sorter(opts),
      }):find()
      return
    else
      vim.notify("telescope.nvim not available, falling back to vim.ui.select", vim.log.levels.WARN)
    end
  end

  vim.ui.select(results, { prompt = title .. ": " }, function(selected)
    if selected then
      vim.cmd.edit(selected)
    end
  end)
end

return M
