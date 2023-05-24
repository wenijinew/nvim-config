local M = {}

local configuration = {
    opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    },
    vopts = {
        mode = "v",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    },

    -- language server keymapping opts
    lopts = {
        mode = "n",
        prefix = ".",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    },

    mappings = {
        f = {
            name = "Telescope",
            a = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
            b = { "<cmd>Telescope git_branches<cr>", "Find Branches" },
            c = { "<cmd>Telescope commands<cr>", "Find Commands" },
            d = { function()
                require("setup.telescope").find_product_repo_files()
            end, "Find Product Repo Files"
            },
            f = { function()
                require("setup.telescope").find_project_files()
            end, "Find Project Files"
            },
            g = { function()
                require("setup.telescope").find_github_repo_files()
            end, "Find Github Repo Files"
            },
            h = { "<cmd>Telescope help_tags<cr>", "Find Nvim Helps" },
            i = { "<cmd>Telescope highlights<cr>", "Find Highlights" },
            j = { function()
                require("setup.telescope").find_mje_jcat_files()
            end, "Find MJE/JCAT/Test Repo Files"
            },
            k = { "<cmd>Telescope keymaps<cr>", "Find Keymaps" },
            l = { "<cmd>Telescope live_grep<cr>", "Find Files by Grep Text" },
            m = { "<cmd>Telescope man_pages<cr>", "Find Man Pages" },
            o = { function()
                require("setup.telescope").find_own_projects_files()
            end, "Find Own Project Files"
            },
            r = { "<cmd>Telescope oldfiles<cr>", "Find Recent Files" },
            t = { function()
                require("setup.telescope").find_tag_files()
            end, "Find Files by Tags"
            },
            w = { function()
                require("setup.telescope").find_workspace_files()
            end, "Find Workspace Files"
            },
        },
        -- disable gitsigns due to performance issue
        g = {
            name = "Gitsigns",
            l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            m = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
            n = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
                "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
                "Undo Stage Hunk",
            },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            C = {
                "<cmd>Telescope git_bcommits<cr>",
                "Checkout commit(for current file)",
            },
            d = {
                "<cmd>Gitsigns diffthis HEAD<cr>",
                "Git Diff",
            },
        },
        D = {
            name = "Gitgutter",
            a = { "<cmd>GitGutterStageHunk<cr>", "Show Diff" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            C = {
                "<cmd>Telescope git_bcommits<cr>",
                "Checkout commit(for current file)",
            },
            d = { "<cmd>GitGutterDiffOrig<cr>", "Show Diff" },
            e = { "<cmd>GitGutterToggle<cr>", "Enable/Disable Gitgutter" },
            f = { "<cmd>GitGutterQuickFix<cr>", "Show Quick Fix Window" },
            l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            n = { "<cmd>GitGutterNextHunk<cr>", "Next Hunk" },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            p = { "<cmd>GitGutterPreviewHunk<cr>", "Preview Hunk" },
            u = { "<cmd>GitGutterUndoHunk<cr>", "Undo Hunk" },
        },
        v = {
            name = "Generic keys",
            -- the below command cannot work, what's the reason?
            a = { function()
                vim.cmd("wa")
                vim.cmd("mks! " .. vim.v.this_session)
            end, "Save session" },
            b = { "<cmd>NvimTreeOpen $DJ_REPO_ROOT<cr>", "Open user development repositories" },
            c = { "<c-w>c", "Close the current window" },
            C = { "<cmd>tabc<cr>", "Close the current tab" },
            d = { "<cmd>w<cr> <cmd>bd<cr>", "Delete the current buffer" },
            D = { "<cmd>bd!<cr>", "Forcely delete the current buffer" },
            e = { "<cmd>NvimTreeFindFileToggle<cr>", "Open/Close Nvimtree" },
            f = { "<cmd>PymodeLintAuto<cr>", "AutoFix PEP8 Errors(Pymode)" },
            i = { "<cmd>IndentBlanklineToggle<cr>", "Toggles Indent-Blankline" },
            p = { "<cmd>PymodeLint<cr>", "Run code check(Pymode)" },
            l = { "<cmd>SymbolsOutline<cr>", "Show/Hide SymbolsOutline" },
            m = { "<cmd>vi $home/.vimrc<cr> <cmd>split<cr> <cmd>vi $home/.vim/colors/hacker.vim<cr> <cmd>split<cr> <cmd>vi $home/.config/nvim/init.lua<cr>",
                "Modify init files" },
            n = { "<cmd>set nonu<cr> <cmd>set nornu<cr>", "No number" },
            N = { "<cmd>set nu<cr> <cmd>set rnu<cr>", "Set number" },
            -- the below command cannot work, what's the reason?
            j = { "<cmd>%!jq '.'<esc>", "Format JSON file" },
            o = { "<c-w>o", "Close other windows" },
            O = { "<cmd>tabo<cr>", "Close other tabs" },
            s = { "<cmd>nohlsearch<cr>", "Do not highlight search" },
            r = { "<cmd>retab<cr> <cmd>%s/ *$//g<cr>", "Retab and remove trailing spaces" },
            t = { "<cmd>tabp<cr>", "Go to previous tab" },
            x = { "<cmd>q<cr>", "Quit all without saving" },
            -- v = { "<cmd>wa<cr> <cmd>mks! $VIM_SESSION_ROOT/t.vim<cr> <cmd>qa<cr>", "Quit all without saving" },
            --v = { "<cmd>wa<cr><cmd>mks! v:this_session<cr><cmd>qa<cr>",
            --    "Save session and quit" },
            --v = { function()
            --    vim.ui.input({ prompt = "session name: ", default = "t.vim" },
            --        function(session_name)
            --            if session_name then
            --                session_name = "$VIM_SESSION_ROOT/" .. session_name
            --                vim.cmd("mks! " .. session_name)
            --            end
            --        end)
            --    vim.cmd("qa")
            --end, "Save session and Quit" }
            v = { function()
                vim.cmd("wa")
                vim.cmd("mks! " .. vim.v.this_session)
                vim.cmd("qa")
            end, "Save session and Quit" },
        },
        p = {
            name = "Packer",
            c = { "<cmd>PackerCompile<cr>", "Compile" },
            i = { "<cmd>PackerInstall<cr>", "Install" },
            s = { "<cmd>PackerSync<cr>", "Sync" },
            S = { "<cmd>PackerStatus<cr>", "Status" },
            u = { "<cmd>PackerUpdate<cr>", "Update" },
        },
        s = {
            name = "Split",
            b = { "<cmd>lua vim.diagnostic.goto_next()<cr>" },
            B = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>" },
            c = { "<cmd>cclose<cr>", "Close QuickFix Window" },
            C = { "<cmd>lclose<cr>", "Close Location List" },
            D = { "<cmd>colorscheme hacker_daytime<cr>", "Use hacker-daytime theme" },
            f = { "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
            F = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>" },
            l = { "<cmd>FloatermNew lazygit<cr>", "Open lazygit in new Flowterm" },
            n = { "<cmd>lnext<cr>", "Next item in Location List" },
            N = { "<cmd>colorscheme hacker_night<cr>", "Use hacker-night theme" },
            o = { "<cmd>copen<cr>", "Open QuickFix Window" },
            O = { "<cmd>lopen<cr>", "Open Location List" },
            p = { "<cmd>lprev<cr>", "Previous item in Location List" },
            r = { "<cmd>FloatermNew ranger<cr>", "Open ranger in new Flowterm" },
            H = { "<cmd>colorscheme hacker_default<cr>", "Use hacker-default theme" },
            i = { "<cmd>luafile <afile><cr>", "Source current file" },
            I = { "<cmd>luafile $home/.config/nvim/init.lua<cr>", "Source init.lua" },
            s = { "<cmd>split<cr>", "Horizontal split" },
            v = { "<cmd>vsplit<cr>", "Vertical split" },
            -- reserved for session loading
            -- TODO: show session name in status line - change lualine config
            T = { "<cmd>so $VIM_SESSION_ROOT/ran-common-test.vim<cr>", "Load RAN-COMMON-TEST Session" },
            R = { "<cmd>so $VIM_SESSION_ROOT/rensa.vim<cr>", "Load RENSA Session" },
            A = { "<cmd>so $VIM_SESSION_ROOT/fan.vim<cr>", "Load FAN Session" },
            V = { "<cmd>so $VIM_SESSION_ROOT/vim.vim<cr>", "Load VIM Session" },
        }
    },

    vmappings = {
        ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    },

    -- language server key mappings
    lmappings = {
        d = {
            name = "Diagnostics",
            f = { "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
            b = { "<cmd>lua vim.diagnostic.goto_next()<cr>" },
            F = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>" },
            B = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>" },
        },
        l = {
            name = "Code",
            f = { "<cmd>lua vim.lsp.buf.format({anync = true})<CR>", "Format Document" },
            r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
            a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
            d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
            i = { "<cmd>LspInfo<CR>", "LSP Infomation" }
        },
        g = {
            name = "Goto",
            d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
            D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
            s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
            I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
            t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition" }
        }
    }
}

M.setup = function()
    local which_key = require("which-key")

    local opts = configuration.opts
    local mappings = configuration.mappings
    which_key.register(mappings, opts)

    local vopts = configuration.vopts
    local vmappings = configuration.vmappings
    which_key.register(vmappings, vopts)

    local lopts = configuration.lopts
    local lmappings = configuration.lmappings
    which_key.register(lmappings, lopts)
end

return M
