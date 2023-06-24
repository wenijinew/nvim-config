-- TODO:
-- 1. apply log to all sub-modules
-- DONE 2. move config files to redwood repo for version control
-- DONE 3. how to apply customized formatting for lsp formatting - config/lsp/null-ls.lua
-- 4. write article for aspects
--
-- vim.api.nvim_echo({ { '# \n', 'ErrorMsg' } }, false, {})
-- :lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))
-- :lua print(pcall(vim.api.nvim_get_hl_by_name, name, not cterm))

require("config.vimopt").setup()
require('config.keymaps').setup()
require('config.theme.hacker').setup()

require("setup.plugins")
-- due to proxy issue, masan cannot work
--require("mason").setup()
--require("mason-lspconfig").setup
--{
--    ensure_installed = { "pylsp" },
--    automatic_installation = true,
--    log_level = vim.log.levels.DEBUG
--}
require("setup.lsp").setup()
-- require("lspconfig").pylsp.setup {
--     settings = {
--         pylsp = {
--             plugins = {
--                 pyflakes = {
--                     enabled = true,
--                 },
--                 yapf = {
--                     enabled = true,
--                 },
--                 pycodestyle = {
--                     enabled = true,
--                     ignore = { 'W391' },
--                     maxLineLength = 100
--                 },
--                 pylint = {
--                     enabled = true
--                 },
--                 flake8 = {
--                     enabled = true,
--                     config = os.getenv("HOME") .. "/.config/flake8"
--                 },
--                 autopep8 = {
--                     enabled = true
--                 }
--             }
--         }
--     }
-- }
require("setup.outline").setup()
require("setup.gitsigns").setup()
require('setup.whichkey').setup()
require('setup.telescope').setup()
require('setup.lualine').setup()
require('setup.breadcrumbs').setup()
require('setup.nvimtree').setup()
require('setup.nvimcmp').setup()
-- dependent on npm, have to solve proxy/firewall issue before using it.
-- require('setup.treesitter').setup()

-- require('setup.coc').setup()
require('setup.colorizer').setup()
