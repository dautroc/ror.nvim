local M = {}


function M.select_finders()
  vim.ui.select(
    { "Models", "Controllers", "Migrations", "Views", "Mailers", "Helpers", "Jobs", "Services", "Workers", "Policies" },
    { prompt = "What are you looking for?" },
    function (finder)
      if finder == "Models" then
        require("ror.finders.model").find()
      elseif finder == "Controllers" then
        require("ror.finders.controller").find()
      elseif finder == "Migrations" then
        require("ror.finders.migration").find()
      elseif finder == "Views" then
        require("ror.finders.view").find()
      elseif finder == "Mailers" then
        require("ror.finders.mailer").find()
      elseif finder == "Helpers" then
        require("ror.finders.helper").find()
      elseif finder == "Jobs" then
        require("ror.finders.job").find()
      elseif finder == "Services" then
        require("ror.finders.service").find()
      elseif finder == "Workers" then
        require("ror.finders.worker").find()
      elseif finder == "Policies" then
        require("ror.finders.policy").find()
      end
    end
  )
end

return M
