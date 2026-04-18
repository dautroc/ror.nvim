# ror.nvim

A fork of [weizheheng/ror.nvim](https://github.com/weizheheng/ror.nvim) with RSpec support and snacks.nvim picker.

YouTube demo [video](https://www.youtube.com/watch?v=uPyklWpVjFI).

## What's Different

- **[snacks.nvim](https://github.com/folke/snacks.nvim) picker support** — telescope is no longer required; falls back to `vim.ui.select` when neither is available
- **RSpec / `spec/` support** — navigators and finders auto-detect `spec/` or `test/` directories, supporting both minitest and RSpec projects
- **Bidirectional test navigation** — jump between source and test files from any directory
- **Bug fixes** — routes list handles missing sync, corrected `RorFinders` command

## Installation

### lazy.nvim

```lua
return {
  "dautroc/ror.nvim",
  config = function()
    require("ror").setup({
      picker = "snacks",
      test = {
        message = {
          file = "Running test file...",
          line = "Running single test...",
        },
        coverage = {
          up = "DiffAdd",
          down = "DiffDelete",
        },
        notification = {
          timeout = false,
        },
        pass_icon = "✅",
        fail_icon = "❌",
      },
    })
  end,
  keys = {
    { "<leader>r.", "<cmd>RorCommands<cr>",                                               desc = "Rails: Command palette" },
    -- Test
    { "<leader>rt", "<cmd>RorTestRun<cr>",                                                desc = "Rails: Test file" },
    { "<leader>rl", "<cmd>RorTestRun Line<cr>",                                           desc = "Rails: Test line" },
    { "<leader>rc", "<cmd>RorTestClear<cr>",                                              desc = "Rails: Clear test results" },
    { "<leader>ra", "<cmd>RorTestAttachTerminal<cr>",                                     desc = "Rails: Attach test terminal" },
    -- Coverage
    { "<leader>rv", "<cmd>RorShowCoverage<cr>",                                           desc = "Rails: Show coverage" },
    { "<leader>rx", "<cmd>RorClearCoverage<cr>",                                          desc = "Rails: Clear coverage" },
    -- Navigation
    { "<leader>rm", function() require("ror.navigations").go_to_model("normal") end,      desc = "Rails: Go to model" },
    { "<leader>rk", function() require("ror.navigations").go_to_controller("normal") end, desc = "Rails: Go to controller" },
    { "<leader>re", function() require("ror.navigations").go_to_test("normal") end,       desc = "Rails: Go to test" },
    { "<leader>rw", function() require("ror.navigations").go_to_view() end,               desc = "Rails: Go to view" },
    -- Navigation (vsplit)
    { "<leader>rM", function() require("ror.navigations").go_to_model("vsplit") end,      desc = "Rails: Vsplit model" },
    { "<leader>rK", function() require("ror.navigations").go_to_controller("vsplit") end, desc = "Rails: Vsplit controller" },
    { "<leader>rE", function() require("ror.navigations").go_to_test("vsplit") end,       desc = "Rails: Vsplit test" },
    -- Finders / Generators / Destroyers
    { "<leader>rf", "<cmd>RorFinders<cr>",                                                desc = "Rails: Find files" },
    { "<leader>rg", "<cmd>RorGenerators<cr>",                                             desc = "Rails: Generators" },
    { "<leader>rd", "<cmd>RorDestroyers<cr>",                                             desc = "Rails: Destroyers" },
    -- Routes / Schema / CLI
    { "<leader>rr", "<cmd>RorListRoutes<cr>",                                             desc = "Rails: List routes" },
    { "<leader>rR", function() require("ror.routes").sync_routes() end,                   desc = "Rails: Sync routes" },
    { "<leader>rs", "<cmd>RorSchemaListColumns<cr>",                                      desc = "Rails: Schema columns" },
    { "<leader>ri", "<cmd>RorCliCommands<cr>",                                            desc = "Rails: CLI commands" },
    -- Misc
    { "<leader>rp", "<cmd>RorAddFrozenStringLiteral<cr>",                                 desc = "Rails: Add frozen string literal" },
  },
}
```

## Dependencies

Choose one of the following picker backends:

1. [telescope](https://github.com/nvim-telescope/telescope.nvim) (default)
2. [snacks.nvim](https://github.com/folke/snacks.nvim) (requires `snacks.picker`)

## Optional Dependencies

1. [nvim-notify](https://github.com/rcarriga/nvim-notify) — beautiful test notifications
2. [dressing.nvim](https://github.com/stevearc/dressing.nvim) — better `vim.ui.select` and `vim.ui.input`
3. [Luasnip](https://github.com/L3MON4D3/LuaSnip) — for snippets support

## Features

See the [original repo](https://github.com/weizheheng/ror.nvim#features) for feature demos.

- Test helpers (run file, single test, coverage, debugger popup)
- Finders (models, controllers, views, migrations, tests)
- Generators & Destroyers (model, mailer, migration, controller, system test)
- CLI helpers (bundle, db:migrate, db:rollback)
- Navigation (model, view, controller, test — with vsplit support)
- Routes helpers (list & sync)
- Schema helpers (list columns)
- Snippets + [ror-lsp](https://github.com/weizheheng/ror-lsp) (experimental)

### Prerequisite for minitest

If you are using minitest, install [minitest-json-reporter](https://rubygems.org/gems/minitest-json-reporter):

```ruby
group :test do
  gem "minitest-json-reporter"
end
```
