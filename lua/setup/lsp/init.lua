-- https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-1-b3a17ddbe611#:~:text=Neovim%20supports%20the%20Language%20Server,are%20provided%20by%20third%20parties.
local M = {}
local log = require('utils.log')

-- due to proxy issue, it might failed to download these servers.
-- the workaround is to download the servers manually from laptop(or anyother
-- server without proxy issue), then copy the downloaded files to the
-- installation directory of lsp servers.
-- the default installation directory of lsp servers is:
-- $HOME/.local/share/nvim/lsp_servers
-- check code of nvim-lsp-installer:
-- nvim-lsp-installer/settings.lua
-- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" }
-- the download code for jdtls is:
-- nvim-lsp-installer/servers/jdtls/init.lua
-- local function download_jdtls()
-- after downloading, it will unpack the downloaded file and rename the folder
-- name to lsp server name, for example, jdtls.
-- so, manually downloaded file should do the same change and then it will work
-- by default.
-- sumneko_lua download url:
-- download url: https://api.github.com/repos/sumneko/vscode-lua/releases
-- downloaded file format is *.vsix and need to convert to *.tar by 7zip, then
-- copy from laptop to team server
-- jdtls download url:
-- https://download.eclipse.org/jdtls/snapshots/?d
local servers = {
    jdtls = {},
    sumneko_lua = {},
    pylsp = {},
}

function M.setup_document_symbols(client, bufnr)
    vim.g.navic_silence = false -- can be set to true to suppress error
    local symbols_supported = client.supports_method "textDocument/documentSymbol"
    if not symbols_supported then
        log:debug("skipping setup for document_symbols, method not supported by " .. client.name)
        return
    end
    local status_ok, navic = pcall(require, "nvim-navic")
    if status_ok then
        navic.attach(client, bufnr)
    end
end

function M.lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
    keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local function on_attach(client, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(bufnr, 'mod', true)
    M.setup_document_symbols(client, bufnr)
    M.lsp_keymaps(bufnr)
end

local opts = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    -- the settings below is to solve "Undefined global `vim`."
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true
                },
                rope_autoimport = {
                    enabled = true,
                },
                pyflakes = {
                    enabled = true,
                },
                pylint = {
                    enabled = true,
                },
                flake8 = {
                    enabled = true,
                    config = os.getenv("HOME") .. "/.config/flake8"
                },
                mccabe = {
                    enabled = true,
                }
            }
        }
    },
}

function M.setup()
    require("setup.lsp.installer").setup(servers, opts)
    require("setup.lsp.null-ls").setup()
    -- TODO: investigate how to use nvim-jdtls
    -- require("config.lsp.nvimjdtls").setup()
end

return M
