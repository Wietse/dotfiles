return require('packer').startup(function(use)

  local use = use

  -- Package manager Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'

  -- Autocompletion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-cmdline", -- command line
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-nvim-lua", -- nvim config completions
      "hrsh7th/cmp-nvim-lsp", -- lsp completions
      "hrsh7th/cmp-path", -- file path completions
      -- "saadparwaiz1/cmp_luasnip", -- snippets completions
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip"
    },
  })

  -- Fuzzy finder
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'
  use 'sharkdp/fd'

  -- Git integration
  use 'tpope/vim-fugitive'

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
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
end)
