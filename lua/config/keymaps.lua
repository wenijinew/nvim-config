local M = {}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

function M.setup()
    -- //////////////////////////////////////////////////////
    -- we use which-key to manage key mapping with leader
    -- use space as mapleader " "
    -- use comma as mapleader ","
    -- //////////////////////////////////////////////////////
    vim.g.mapleader = ","
    keymap("n", "<Leader>e", ":NvimTreeFindFileToggle<cr>", opts)
    keymap("n", "<Leader>w", ":w<cr>", opts)
    keymap("n", "<Leader>z", ":wincmd _<cr> :wincmd |<cr>", opts)
    keymap("n", "<M-z>", ":wincmd =<cr>", opts)
    keymap("n", "<M-n>", ":bnext<cr>", opts)
    keymap("n", "<M-m>", ":bprevious<cr>", opts)
    keymap("n", "<C-l>", ":tabe<cr>", opts)
    keymap("n", "<C-m>", ":tabn<cr>", opts)
    -- save session and quit
    keymap("n", "<Leader>sS", "<cmd>lua vim.fn.save_session<cr>", opts)
    -- diagnostics navigation
    keymap("n", "<Leader>sb", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>", opts)
    keymap("n", "<Leader>sf", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>", opts)
    keymap("n", "<Leader>sB", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    keymap("n", "<Leader>sF", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    -- run external commands
    keymap("n", "<Leader>J", ":%!jq '.'<ESC>", opts)
    keymap("n", "<Leader>S", ":%!js-beautify<ESC>", opts)
    keymap("n", "<Leader>X", ":%!xmllint --format -<ESC>", opts)
end

return M
