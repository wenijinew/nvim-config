local M = {}

function M.setup()
    require("lazy").setup({
        { "nvim-treesitter/nvim-treesitter" },
        {
            'nvim-lualine/lualine.nvim',
            dependencies = {
                'nvim-tree/nvim-web-devicons',
            }
        },
        {
            "SmiteshP/nvim-navic",
        },

        { 'folke/which-key.nvim' },
        -- indent blank line to improve readability
        { 'lukas-reineke/indent-blankline.nvim' },
        -- auto-completion
        -- { 'neoclide/coc.nvim', branch = 'release', lazy = false, },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
            }
        },
        -- git integration
        { 'airblade/vim-gitgutter', branch = 'master' },
        { 'lewis6991/gitsigns.nvim' },
        -- searching
        {
            'nvim-telescope/telescope.nvim',
            version = '0.1.0',
            dependencies = {
                'nvim-lua/plenary.nvim'
            }
        },
        -- explorer
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = {
                'nvim-tree/nvim-web-devicons',
            }
        },
        -- language servers
        { 'wenijinew/python-mode', branch = 'e463652c' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'folke/trouble.nvim' },
        {
            'neovim/nvim-lspconfig',
            lazy = false,
            version = 'v0.1.4',
            config = function()
                require("config.lsp").setup()
            end,
            dependencies = {
                "williamboman/nvim-lsp-installer"
            }
        },
        -- highlighting
        {
            "wenijinew/nvim-colorizer.lua",
        },
        {
            "wenijinew/nvim-treesitter",
        },
    })
end

return M
