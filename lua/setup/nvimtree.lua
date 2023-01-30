-- ////////////////////////////////////////////////////////////////////////////
-- Tips:
-- To show all supported commands, in nvim-tree panel, type 'g?'
-- ////////////////////////////////////////////////////////////////////////////
local M = {}

local icons = require('config.icons')
local log = require('utils.log')

function M.setup()
    -- if version is lower than 0.8, then return with debug message
    -- TODO: print current nvim version in logging message
    if vim.fn.has "nvim-0.8" ~= 1 then
        return
    end

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true
    require("nvim-tree").setup({
        update_cwd = true,
        view = {
            adaptive_size = true,
            signcolumn = "yes",
            mappings = {
                list = {
                    { key = "s", action = "split" },
                    { key = "v", action = "vsplit" },
                    { key = "l", action = "tabnew" }
                }
            }
        },
        renderer = {
            highlight_git = true,
            icons = {
                webdev_colors = true,
                git_placement = "after",
                modified_placement = "before",
                glyphs = {
                    git = {
                        unstaged = icons.git.FileUnstaged,
                        staged = icons.git.FileStaged,
                        unmerged = icons.git.FileUnmerged,
                        renamed = icons.git.FileRenamed,
                        untracked = icons.git.FileUntracked,
                        deleted = icons.git.FileDeleted,
                        ignored = icons.git.FileIgnored,
                    },
                },
            }
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
            debounce_delay = 50,
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR,
            },
            icons = {
                hint = icons.diagnostics.Hint,
                info = icons.diagnostics.Information,
                warning = icons.diagnostics.Warning,
                error = icons.diagnostics.Error,
            },
        },
        modified = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
    })
    require('nvim-web-devicons').setup({
        color_icons = true,
    })
end

return M
