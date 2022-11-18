vim.cmd [[packadd packer.nvim]]

require('packer').startup(
    function(use)

        use "wbthomason/packer.nvim"

        -- Git integration
        use 'tpope/vim-fugitive'

        -- Syntax highlighting for practically any language
        use 'sheerun/vim-polyglot'

        -- Colorscheme
        use 'sainnhe/gruvbox-material'

        -- Commenting code
        use 'tomtom/tcomment_vim'

        -- Interaction with tmux
        use 'christoomey/vim-tmux-navigator'

        -- Cute UI
        use 'vim-airline/vim-airline'
        use 'vim-airline/vim-airline-themes'

        -- LSP
        -- https://github.com/VonHeikemen/lsp-zero.nvim
        -- https://github.com/williamboman/mason.nvim
        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-nvim-lua'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
            }
        }

        -- Fuzzy finder
        use {
            'nvim-lua/telescope.nvim', tag = '0.1.0',
            requires = {
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'},
                {'jremmen/vim-ripgrep'},
                {'sharkdp/fd'},
            }
        }

    end
)


-- Configuration of lsp/lsp-zero
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()

-- Configuration of telescope
require('telescope').setup()
