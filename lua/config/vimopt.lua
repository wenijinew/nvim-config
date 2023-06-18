local M = {}
local icons = require('config.icons')
local log = require('utils.log')

-- good designed code to create autocmds by given 'table'
-- borrowed from lunarvim
local function _define_autocmds(definitions)
    for _, entry in ipairs(definitions) do
        local event = entry[1]
        local opts = entry[2]
        if type(opts.group) == "string" and opts.group ~= "" then
            local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
            if not exists then
                vim.api.nvim_create_augroup(opts.group, {})
            end
        end
        vim.api.nvim_create_autocmd(event, opts)
    end
end

local autocmds_definitions = {
    {
        "BufEnter",
        {
            group = "_changedir",
            pattern = "*",
            desc = "Set the current directory",
            callback = function()
                vim.cmd [[
                silent! lcd %:p:h
                ]]
            end
        },
    },
    {
        { "BufEnter" },
        {
            group = "_settw_300",
            pattern = { "*.vim", "*.vimrc" },
            desc = "Set textwidth for vim",
            command = "setlocal tw=300"
        }
    },
    {
        { "BufEnter" },
        {
            group = "_settw_100",
            pattern = { "*.java" },
            desc = "Set textwidth for java",
            command = "setlocal tw=120"
        }
    },
    {
        { "BufEnter" },
        {
            group = "_settw_79",
            pattern = { "*.py", "*.lua", "*.sh", "*.csh" },
            desc = "Set textwidth for python",
            command = "setlocal tw=79"
        }
    },
    {
        { "FileType" },
        {
            group = "_set_K",
            pattern = { "java", "xml", "scala" },
            desc = "Set keymap for K",
            callback = function()
                vim.cmd [[
                setlocal isk=a-z,A-Z,48-57,_
                nnoremap <buffer> K :wincmd s<CR> :tag <C-R><C-W><CR>
                ]]
            end
        }
    },
    {
        { "FileType" },
        {
            group = "_set_vim_lua_K",
            pattern = { "vim", "lua", },
            desc = "Set keymap for K",
            callback = function()
                vim.cmd [[
                setlocal isk=a-z,A-Z,48-57,_
                nnoremap <buffer> K :h <C-R><C-W><CR>
                ]]
            end
        }
    },
    -- auto format files when saving, use null-ls sources
    {
        "BufWritePre",
        {
            group = "_auto_format_on_save",
            pattern = { "*.lua", "*.py", "*.java" },
            desc = "Automatically format on saving",
            callback = function()
                vim.lsp.buf.format {
                    timeout_ms = 1000,
                    filter = function(client)
                        local filetype = vim.bo.filetype
                        local n = require "null-ls"
                        local s = require "null-ls.sources"
                        local method = n.methods.FORMATTING
                        local available_formatters = s.get_available(filetype, method)

                        if #available_formatters > 0 then
                            return client.name == "null-ls"
                        elseif client.supports_method "textDocument/formatting" then
                            return true
                        else
                            return false
                        end
                    end
                }
            end,
        }
    },
    {
        "BufWritePre",
        {
            group = "_auto_format_on_save",
            pattern = { "*.java" },
            desc = "Automatically format on saving",
            callback = function()
                vim.cmd [[
                retab
                %s/ *$//g
                execute "normal \<C-O>"
                ]]
            end,
        }
    },
    -- using auto sync, I don't dare to open plugins.lua file!
    -- {
    --     "BufWritePost",
    --     {
    --         group = "_auto_packer_sync",
    --         pattern = "plugins.lua",
    --         desc = "Automatically sync packer plugins",
    --         command = "source <afile> | PackerSync"
    --     }
    -- },
    {
        "BufWritePost",
        {
            group = "_auto_update_gitgutter",
            pattern = { "*.py", "*.java" },
            desc = "Automatically update gitgutter signs",
            command = "GitGutterAll"
        }
    },
    -- the below code will cause highlight doesn't work after entering vim
    -- TODO: investigate the reason
    --{
    --    "VimEnter",
    --    {
    --        group = "_reset_runtimepath",
    --        desc = "Automatically remove duplicated runtimepath entries",
    --        callback = function()
    --            if vim.fn.has "nvim-0.8" ~= 1 then
    --                return
    --            end
    --            local parser_rtp = vim.api.nvim_get_runtime_file('parser', true)
    --            local bundle_pathes = {}
    --            for i, v in ipairs(parser_rtp) do
    --                if string.find(v, "runtime.*treesitter") then
    --                    table.insert(bundle_pathes, v)
    --                    log.debug(v)
    --                end
    --            end
    --            local rtp = vim.api.nvim_get_runtime_file('*', true)
    --            local indexes_to_remove = {}
    --            for i, v in ipairs(rtp) do
    --                if string.find(v, "runtime.*treesitter") then
    --                    table.insert(indexes_to_remove, i)
    --                    log.debug(i .. ":::" .. v)
    --                end
    --            end
    --            for i, v in ipairs(indexes_to_remove) do
    --                table.remove(rtp, i)
    --                log.debug(v .. ' is removed from rtp')
    --            end
    --            vim.api.nvim_set_option("runtimepath", table.concat(rtp, ','))
    --            parser_rtp = vim.api.nvim_get_runtime_file('parser', true)
    --            for i, v in ipairs(parser_rtp) do
    --                log.debug(i .. ">>>" .. v)
    --            end
    --        end
    --    }
    --},
}

-- define diagnostics signs for default diagnostics names and python-mode
-- diagnostics names.
-- it's used in the function _create_signs
local diagnostics_signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
    -- here, it might not work, so we set the global symbols separately by
    -- vim.g.pymode_lint_todo_symbol and the similar
    -- see details in https://github.com/python-mode/python-mode/compare/develop...wenijinew:python-mode:e463652c
    { name = "PymodeW", text = icons.diagnostics.Warning },
    { name = "PymodeD", text = icons.ui.Note },
    { name = "PymodeC", text = icons.diagnostics.Hint },
    { name = "PymodeR", text = icons.ui.Circle },
    { name = "PymodeE", text = icons.diagnostics.Error },
    { name = "PymodeI", text = icons.diagnostics.Information },
    { name = "PymodeF", text = icons.diagnostics.Information },
}

local function _create_signs()
    for _, sign in ipairs(diagnostics_signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.name,
            text = sign.text,
            numhl = sign.name,
        })
    end
    -- set python-mode symbols
    vim.g.pymode_lint_todo_symbol = icons.diagnostics.Warning
    vim.g.pymode_lint_docs_symbol = icons.ui.Note
    vim.g.pymode_lint_comment_symbol = icons.diagnostics.Warning
    vim.g.pymode_lint_visual_symbol = icons.diagnostics.Question
    vim.g.pymode_lint_error_symbol = icons.diagnostics.Error
    vim.g.pymode_lint_info_symbol = icons.diagnostics.Information
    vim.g.pymode_lint_pyflakes_symbol = icons.diagnostics.BoldInformation
end

local function _show_highest_severity_diagnostics()
    local ns = vim.api.nvim_create_namespace("b.w")
    local orig_signs_handler = vim.diagnostic.handlers.signs
    local orig_virtual_text_handler = vim.diagnostic.handlers.virtual_text
    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, diagnostics, opts)
            local highest_severities = {}
            for _, d in pairs(diagnostics) do
                local h = highest_severities[d.lnum]
                -- higher priority has smaller int value
                if not h or d.severity < h.severity then
                    highest_severities[d.lnum] = d
                end
            end
            local highest_severities_diagnostics = vim.tbl_values(highest_severities)
            orig_signs_handler.show(ns, bufnr, highest_severities_diagnostics, opts)
        end,
        hide = function(_, bufnr)
            orig_signs_handler.hide(ns, bufnr)
        end
    }
    vim.diagnostic.handlers.virtual_text = {
        show = function(_, bufnr, diagnostics, opts)
            local highest_severities = {}
            for _, d in pairs(diagnostics) do
                local h = highest_severities[d.lnum]
                -- if multiple sources, then only choose highest one
                if not h or d.severity < h.severity then
                    -- only show WARN and more severie diagnostics
                    if d.severity <= vim.diagnostic.severity.WARN then
                        highest_severities[d.lnum] = d
                    end
                end
            end
            local highest_severities_diagnostics = vim.tbl_values(highest_severities)
            orig_virtual_text_handler.show(ns, bufnr, highest_severities_diagnostics, opts)
        end,
        hide = function(_, bufnr)
            orig_virtual_text_handler.hide(ns, bufnr)
        end
    }
end

local function _config_diagnostics()
    vim.diagnostic.config({
        virtual_text = {
            --prefix = function(diagnostic)
            --    if diagnostic.severity == vim.diagnostic.severity.ERROR then
            --        return icons.diagnostics.Error
            --    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
            --        return icons.diagnostics.Warning
            --    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
            --        return icons.diagnostics.Information
            --    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
            --        return icons.diagnostics.Hint
            --    else
            --        return icons.diagnostics.Trace
            --    end
            --end,
            prefix = icons.misc.Dot,
            format = function(diagnostic)
                return string.format("[%s] %s: %s", diagnostic.source, diagnostic.code or icons.diagnostics.Debug,
                    diagnostic.message)
            end,
        }
    })
end

local function _set_opts()
    -- ////////////////////////////////////////////////////
    -- generic options
    -- showtabline = 2: always show tab as breadcrumbs needs it
    -- ////////////////////////////////////////////////////
    vim.opt.autochdir = true
    vim.opt.autowriteall = true
    vim.opt.colorcolumn = '+1'
    vim.opt.cursorline = true
    vim.opt.completeopt = 'menu,menuone,noselect'
    vim.opt.expandtab = true
    vim.opt.ignorecase = true
    vim.opt.lcs = 'tab:>.,trail:-'
    vim.opt.mouse = ''
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.shiftwidth = 4
    vim.opt.signcolumn = 'yes:1'
    vim.opt.showtabline = 2
    vim.opt.laststatus = 3
    vim.opt.tabstop = 4
    vim.opt.mod = true
    -- colorscheme general settings
    vim.cmd('hi clear')
    vim.o.background = 'dark'
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    vim.o.termguicolors = true
    vim.g.colors_name = 'hacker'
    -- to avoid the error caused by missed module: vim.filetype.detect
    vim.g.do_legacy_filetype = 1

    -- tags
    -- opt.tags and opt.tag don't work
    -- vim.opt.tags:append { "$HOME/.vim/tags" }
    -- vim.opt.tag = vim.bo.tags
    -- cmd works
    vim.cmd('set tags+=/home/egugwen/.vim/tags')

    -- ////////////////////////////////////////////////////
    -- plugin options
    -- ////////////////////////////////////////////////////
    -- gitgutter (when gitsigns enabled, disable gitgutter by default - 0)
    vim.g.gitgutter_enabled = 0
    vim.g.gitgutter_async = 0
    vim.g.gitgutter_highlight_linenrs = 1
    vim.g.gitgutter_sign_priority = 5
    vim.g.gitgutter_sign_allow_clobber = 1
    vim.g.gitgutter_sign_added = icons.ui.BoldLineLeft
    vim.g.gitgutter_sign_removed = icons.ui.BoldLineLeft
    vim.g.gitgutter_sign_removed_first_line = icons.ui.BoldLineLeft
    vim.g.gitgutter_sign_removed_above_and_below = icons.ui.BoldLineLeft
    vim.g.gitgutter_sign_modified = icons.ui.BoldLineLeft
    vim.g.gitgutter_sign_modified_removed = icons.ui.BoldLineLeft
    vim.g.gitgutter_preview_win_floating = 1
    -- python syntax highlight
    vim.g.python_highlight_all = 1
    -- java syntax highlight
    vim.g.java_highlight_java_lang_ids = 1
    vim.g.java_highlight_functions = 'style'
    -- pymode
    vim.g.pymode_syntax = 1
    vim.g.pymode_syntax_all = 1
    vim.g.pymode_lint_cwindows = 1
    vim.g.pymode_lint_on_fly = 1
    -- nvim-tree
    vim.g.loaded_netrw = 0
    vim.g.loaded_netrwPlugin = 0
end

function M.setup()
    _set_opts()
    -- ////////////////////////////////////////////////////
    -- autocmds
    -- ////////////////////////////////////////////////////
    _define_autocmds(autocmds_definitions)
    -- ////////////////////////////////////////////////////
    -- signs
    -- ////////////////////////////////////////////////////
    _create_signs()
    -- ////////////////////////////////////////////////////
    -- diagnostics customization
    -- ////////////////////////////////////////////////////
    _config_diagnostics()
    _show_highest_severity_diagnostics()
end

return M
