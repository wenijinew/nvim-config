return require('packer').startup(function(use)
    -- package manager - packer itself
    use {
        'wbthomason/packer.nvim'
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
        }
    }
    use {
        "SmiteshP/nvim-navic",
    }
    -- keymapping management
    use { 'folke/which-key.nvim' }
    -- indent blank line to improve readability
    use { 'lukas-reineke/indent-blankline.nvim' }
    -- auto-completion
    -- use { 'neoclide/coc.nvim', branch = 'release' }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        }
    }
    use { 'onsails/lspkind.nvim' }
    -- git integration
    use { 'airblade/vim-gitgutter', branch = 'master' }
    use { 'lewis6991/gitsigns.nvim' }
    -- searching
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    -- explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        }
    }
    -- language servers
    use { 'wenijinew/python-mode', branch = 'e463652c' }
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { 'folke/trouble.nvim' }
    use {
        'neovim/nvim-lspconfig',
        opt = false,
        tag = 'v0.1.4',
        requires = {
            "williamboman/nvim-lsp-installer",
            "williamboman/mason.nvim"
        }
    }
    -- java outliner
    use {
        'simrat39/symbols-outline.nvim',
    }
    -- highlighting
    use {
        "wenijinew/nvim-treesitter",
    }
    use {
        "wenijinew/nvim-colorizer.lua",
    }
    -- logging
    use { "Tastyep/structlog.nvim" }
    -- term
    use { "voldikss/vim-floaterm" }
end)
