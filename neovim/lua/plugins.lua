--
-- plugins are "usually" installed in ~/.local/share/nvim/site/pack/packer/start
--

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)

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
                {'hrsh7th/cmp-nvim-lsp-signature-help'},
                {'hrsh7th/cmp-nvim-lua'},
                {'hrsh7th/vim-vsnip'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
            }
        }

        -- Fuzzy finder
        use {
            'nvim-lua/telescope.nvim', tag = '0.1.4',
            requires = {
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'},
                {'jremmen/vim-ripgrep'},
                {'sharkdp/fd'},
            }
        }

        -- ChatGPT
        -- https://github.com/jackMort/ChatGPT.nvim
        use({
            "/Users/wja/projects/ChatGPT.nvim",
            config = function() require("chatgpt").setup({}) end,
            requires = {
                "MunifTanjim/nui.nvim",
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim"
            }
        })

        -- -- ChatGPT
        -- -- https://github.com/dpayne/CodeGPT.nvim
        -- use({
        --    "dpayne/CodeGPT.nvim",
        --    requires = {
        --       "MunifTanjim/nui.nvim",
        --       "nvim-lua/plenary.nvim",
        --    },
        --    config = function()
        --       require("codegpt.config")
        --    end
        -- })

        use 'simrat39/rust-tools.nvim'

    end
)


-- Configuration of lsp/lsp-zero
--
-- LSP Actions:
-- K: Displays hover information about the symbol under the cursor in a floating window. -> vim.lsp.buf.hover().
-- gd: Jumps to the definition of the symbol under the cursor. -> vim.lsp.buf.definition().
-- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. -> vim.lsp.buf.declaration().
-- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. -> vim.lsp.buf.implementation().
-- go: Jumps to the definition of the type of the symbol under the cursor. -> vim.lsp.buf.type_definition().
-- gr: Lists all the references to the symbol under the cursor in the quickfix window. -> vim.lsp.buf.references().
-- gs: Displays signature information about the symbol under the cursor in a floating window.
-- <leader>r: Renames all references to the symbol under the cursor. -> vim.lsp.buf.rename().
-- <leader>f: Format code in current buffer. -> vim.lsp.buf.format().
-- <leader>a: Selects a code action available at the current cursor position. -> vim.lsp.buf.code_action().
-- gl: Show diagnostics in a floating window. -> vim.diagnostic.open_float().
-- [d: Move to the previous diagnostic in the current buffer. -> vim.diagnostic.goto_prev().
-- ]d: Move to the next diagnostic. -> vim.diagnostic.goto_next().
--
local lsp_zero = require('lsp-zero').preset({})
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', {buffer = bufnr})
  vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<cr>', {buffer = bufnr})
  vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', {buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {'pylsp'},
  handlers = {
    lsp_zero.setup(),
    pylsp = function()
      require('lspconfig').pylsp.setup({
        cmd = {"pylsp"},
        -- root_dir = function(fname)
        --   local util = require "lspconfig.util"
        --   table.unpack = table.unpack or unpack -- 5.1 compatibility
        --   local root_files = {
        --       'pyproject.toml',
        --       'setup.py',
        --       'setup.cfg',
        --       'requirements.txt',
        --   }
        --   return util.root_pattern(table.unpack(root_files))(fname) or util.find_git_ancestor(fname)
        -- end,
        settings = {
            pylsp = {
                -- configurationSources = {"flake8"},
                plugins = {
                    pycodestyle = {enabled = false},
                    flake8 = {enabled = false},
                    pylint = {enabled = false},
                    mccabe = {enabled = false},
                    pyflakes = {enabled = false},
                    ruff = {enabled = true},
                }
            }
        }
    })
    end,
  },
})

-- Configuration of telescope
require('telescope').setup()

-- Configuration of rust-tools
local rt = require('rust-tools')
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, {buffer = bufnr})
      vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group, {buffer = bufnr})
    end,
  },
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✖'})
sign({name = 'DiagnosticSignWarn', text = '⚠'})
sign({name = 'DiagnosticSignHint', text = '○'})
sign({name = 'DiagnosticSignInfo', text = '●'})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.api.nvim_set_option('updatetime', 300)

-- vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])


-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
    -- { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '󰁀',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

