local M = {}

local lualine = require('lualine')
local colors = require('config.theme.palette').colors
local theme = require('config.theme.hacker')
local icons = require('config.icons')

local _conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local _filename = {
    'filename',
    cond = _conditions.buffer_not_empty,
    -- how to show full path when it's full screen or have enougth
    -- width, otherwise show relative path?
    path = 2,
}

local _lsp = {
    function()
        local msg = ''
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = icons.ui.Gear,
}

local _normal_theme = {
    a = {
        fg = theme.fg_lualine_highlight,
        bg = theme.bg_lualine_active,
    },
    b = {
        fg = theme.fg_lualine_highlight,
        bg = theme.bg_lualine_highlight,
    },
    c = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active,
    },
    x = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active,
    },
    y = {
        fg = theme.fg_lualine_highlight,
        bg = theme.bg_lualine_highlight,
    },
    z = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active,
    },
}

local _visual_theme = {
    a = {
        fg = theme.fg_lualine_visual_highlight,
        bg = theme.bg_lualine_active
    },
    b = {
        fg = theme.fg_lualine_visual_highlight,
        bg = theme.bg_lualine_visual_highlight,
    },
    c = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active
    },
    x = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active
    },
    y = {
        fg = theme.fg_lualine_visual_highlight,
        bg = theme.bg_lualine_visual_highlight,
    },
    z = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active
    },
}

local _insert_theme = {
    a = {
        fg = theme.fg_lualine_insert_highlight,
        bg = theme.bg_lualine_active
    },
    b = {
        fg = theme.fg_lualine_insert_highlight,
        bg = theme.bg_lualine_insert_highlight
    },
    c = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active
    },
    x = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active
    },
    y = {
        fg = theme.fg_lualine_insert_highlight,
        bg = theme.bg_lualine_insert_highlight
    },
    z = {
        fg = theme.fg_lualine_active,
        bg = theme.bg_lualine_active
    },
}

local _inactive_theme = {
    a = {
        fg = theme.fg_lualine_inactive,
        bg = theme.bg_lualine_inactive
    },
    b = {
        fg = theme.fg_lualine_inactive,
        bg = theme.bg_lualine_inactive
    },
    c = {
        fg = theme.fg_lualine_inactive,
        bg = theme.bg_lualine_inactive
    },
    x = {
        fg = theme.fg_lualine_inactive,
        bg = theme.bg_lualine_inactive
    },
    y = {
        fg = theme.fg_lualine_inactive,
        bg = theme.bg_lualine_inactive
    },
    z = {
        fg = theme.fg_lualine_inactive,
        bg = theme.bg_lualine_inactive
    },
}

local _options = {
    icons_enabled = true,
    theme = {
        normal = _normal_theme,
        visual = _visual_theme,
        insert = _insert_theme,
        inactive = _inactive_theme,
    },
    component_separators = { left = icons.ui.DividerRight, right = icons.ui.DividerLeft },
    section_separators = { left = icons.ui.BoldDividerRight, right = icons.ui.BoldDividerLeft },
    disabled_filetypes = {
        statusline = {},
        winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000
    }
}

local _mode = {
    'mode',
    fmt = function() return " " .. icons.os.Redhat .. " " end,
    padding = { right = 1 },
}

local _bufidx = {
    -- to display buffer index
    -- function works well here, but string 'B:%n' cannot work.
    function()
        return 'B:' .. '%n'
    end,
}

local _searchcount = {
    'searchcount'
}

local _branch = {
    'branch',
    icon = icons.git.Branch,
}

local _diff = {
    'diff',
    symbols = {
        added = icons.git.LineAdded .. ' ',
        modified = icons.git.LineModified .. ' ',
        removed = icons.git.LineRemoved .. ' '
    },
    diff_color = {
        added = { fg = colors.light_green },
        modified = { fg = colors.light_orange },
        removed = { fg = colors.light_red },
    },
    cond = _conditions.hide_in_width,
}

local _diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
        error = icons.diagnostics.BoldError .. ' ',
        warn = icons.diagnostics.BoldWarning .. ' ',
        info = icons.diagnostics.BoldInformation .. ' ',
        hint = icons.diagnostics.BoldHint .. ' ',
    },
    diagnostics_color = {
        error = { fg = colors.light_red },
        warn  = { fg = colors.light_orange },
        info  = { fg = colors.light_cyan },
        hint  = { fg = colors.light_yellow },
    },
}

local _filetype = {
    'filetype',
    fmt = function(str) return '[' .. str .. ']' end,
    colored = true,
    icon_only = false,
}

local _progress = {
    'progress',
}

local _location = {
    'location',
}

local _encoding = {
    'o:encoding',
    fmt = string.upper,
    cond = _conditions.hide_in_width,
}

local configuration = {
    options = _options,
    sections = {
        lualine_a = { _mode, },
        lualine_b = { _bufidx, _diff, _diagnostics, _branch, },
        lualine_c = { _filename, },
        lualine_x = { _lsp, },
        lualine_y = { _searchcount, _filetype, _progress, _location, },
        lualine_z = { _encoding, },
    },
    -- as we use laststatus = 3, we don't need to set statusline for inactive
    -- sections
    inactve_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = { _mode, },
        lualine_b = { _bufidx, },
        lualine_c = {
            {
                'buffers',
                show_filename_only = true,
                mode = 0,
                -- don't ask buffer line floods the whole screen
                max_length = vim.o.columns / 5,
                symbols = {
                    modified = icons.ui.modified
                },
                buffers_color = {
                    active = {
                        fg = theme.fg_tabline_active,
                        bg = theme.bg_tabline_active,
                    },
                    inactive = {
                        fg = theme.fg_tabline_inactive,
                        bg = theme.bg_tabline_inactive,
                    },
                },
            },
        },
        lualine_x = {
            {
                'tabs',
                mode = 0,
                max_length = vim.o.columns / 5,
                tabs_color = {
                    active = {
                        fg = theme.fg_tabline_active,
                        bg = theme.bg_tabline_active,
                    },
                    inactive = {
                        fg = theme.fg_tabline_inactive,
                        bg = theme.bg_tabline_inactive,
                    },
                },
            },
        },
        lualine_y = { _searchcount, _filetype, _progress, _location, },
        lualine_z = { _encoding, },
    },
    -- we use navic(breadcrumbs) as winbar, so leave it as empty here
    winbar = {},
    inactive_winbar = {},
    -- how extensions work here?
    extensions = { "quickfix" }
}

function M.setup()
    lualine.setup(configuration)
end

return M
