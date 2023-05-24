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
require("mason").setup()
require("mason-lspconfig").setup()
require("setup.lsp").setup()
require("setup.outline").setup()
require("setup.gitsigns").setup()
require('setup.whichkey').setup()
require('setup.telescope').setup()
require('setup.lualine').setup()
require('setup.breadcrumbs').setup()
require('setup.nvimtree').setup()
require('setup.nvimcmp').setup()
-- require('setup.coc').setup()
require('setup.colorizer').setup()
