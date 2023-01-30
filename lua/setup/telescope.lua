local M = {}

local _, builtin = pcall(require, "telescope.builtin")
local _, themes = pcall(require, "telescope.themes")
local icons = require("config.icons")

function M.find_product_repo_files(opts)
    opts = opts or {}
    local theme_opts = themes.get_ivy {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal";
        prompt_prefix = icons.ui.Telescope .. " ",
        prompt_title = "~ Product Repo Files ~",
        cwd = vim.call("stdpath", "data"),
        search_dirs = { "$DJ_REPO_ROOT" },
        layout_config = {
            height = 0.6,
            width = 0.8,
            preview_cutoff = 120,
        },
        borderchars = {
            "─", "│", "─", "│", "╭", "╮", "╯", "╰"
        },
    }
    opts = vim.tbl_deep_extend("force", theme_opts, opts)
    builtin.find_files(opts)
end

function M.find_github_repo_files(opts)
    opts = opts or {}
    local theme_opts = themes.get_ivy {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal";
        prompt_prefix = icons.ui.Telescope .. " ",
        prompt_title = "~ Github Repo Files ~",
        cwd = vim.call("stdpath", "data"),
        search_dirs = { "$GITHUB_REPO_ROOT" },
        layout_config = {
            height = 0.6,
            width = 0.8,
            preview_cutoff = 120,
        },
        borderchars = {
            "─", "│", "─", "│", "╭", "╮", "╯", "╰"
        },
    }
    opts = vim.tbl_deep_extend("force", theme_opts, opts)
    builtin.find_files(opts)
end

function M.find_workspace_files(opts)
    opts = opts or {}
    local theme_opts = themes.get_ivy {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal";
        prompt_prefix = icons.ui.Telescope .. " ",
        prompt_title = "~ Workspace Files ~",
        cwd = vim.call("stdpath", "data"),
        search_dirs = { "$WS_REPO_ROOT" },
        find_command = { "find", "$WS_REPO_ROOT", "-type", "f", "-name", "*.lua" },
        layout_config = {
            height = 0.6,
            width = 0.8,
            preview_cutoff = 120,
        },
        borderchars = {
            "─", "│", "─", "│", "╭", "╮", "╯", "╰"
        },
    }
    opts = vim.tbl_deep_extend("force", theme_opts, opts)
    builtin.find_files(opts)
end

function M.find_tag_files(opts)
    opts = opts or {}
    local theme_opts = themes.get_ivy {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal";
        prompt_prefix = icons.ui.Telescope .. " ",
        prompt_title = "~ Tags Files ~",
        cwd = vim.call("stdpath", "data"),
        find_command = { "cat", "$HOME/.vim/tags_files" },
        borderchars = {
            "─", "│", "─", "│", "╭", "╮", "╯", "╰"
        },
    }
    opts = vim.tbl_deep_extend("force", theme_opts, opts)
    builtin.find_files(opts)
end

local function get_pickers(actions)
    return {
        find_files = {
            theme = "dropdown",
            hidden = true,
            layout_strategy = "horizontal";
            layout_config = {
                height = 0.6,
                width = 0.8,
                preview_cutoff = 120,
            },
            borderchars = {
                "─", "│", "─", "│", "╭", "╮", "╯", "╰"
            },
        },
        live_grep = {
            --@usage don't include the filename in the search results
            only_sort_text = true,
            theme = "dropdown",
            layout_strategy = "horizontal";
            layout_config = {
                height = 0.6,
                width = 0.8,
                preview_cutoff = 120,
            },
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        grep_string = {
            only_sort_text = true,
            theme = "dropdown",
        },
        buffers = {
            theme = "dropdown",
            initial_mode = "insert",
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer,
                },
                n = {
                    ["dd"] = actions.delete_buffer,
                },
            },
            layout_strategy = "horizontal";
            layout_config = {
                height = 0.6,
                width = 0.8,
                preview_cutoff = 120,
            },
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        planets = {
            show_pluto = true,
            show_moon = true,
        },
        git_files = {
            theme = "dropdown",
            hidden = true,
            show_untracked = true,
            layout_strategy = "horizontal";
            layout_config = {
                height = 0.6,
                width = 0.8,
                preview_cutoff = 120,
            },
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        lsp_references = {
            theme = "dropdown",
            initial_mode = "normal",
        },
        lsp_definitions = {
            theme = "dropdown",
            initial_mode = "normal",
        },
        lsp_declarations = {
            theme = "dropdown",
            initial_mode = "normal",
        },
        lsp_implementations = {
            theme = "dropdown",
            initial_mode = "normal",
        },
    }
end

function M.setup()
    local ok, actions = pcall(require, "telescope.actions")
    if not ok then
        return
    end
    local telescope = require("telescope")
    telescope.setup {
        defaults = {
            prompt_prefix = icons.ui.Telescope .. " ",
            selection_caret = icons.ui.Forward .. " ",
            history = {
                limit = 200,
            },
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            },
            mappings = {
                i = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-c>"] = actions.close,
                    ["<C-j>"] = actions.cycle_history_next,
                    ["<C-k>"] = actions.cycle_history_prev,
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    ["<CR>"] = actions.select_default,
                },
                n = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                },
            },
            path_display = { "truncate" },
            border = {},
            layout_strategy = "horizontal";
            layout_config = {
                height = 0.6,
                width = 0.8,
            },
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        },
        pickers = get_pickers(actions),
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
        }
    }
end

-- /////////////////////////////////////////////////////////////
-- smartly opens either git_files or find_files, depending on whether the working directory is
-- contained in a Git repo.
-- /////////////////////////////////////////////////////////////
function M.find_project_files(opts)
    opts = opts or {}
    local ok = pcall(builtin.git_files, opts)

    if not ok then
        builtin.find_files(opts)
    end
end

return M
