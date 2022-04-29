"
"--- GENERAL
"
set nocompatible             " not vi-compatible

let g:python3_host_prog = '/Users/wja/.pyenv/versions/3.9.10/envs/nvim-py3.9.10/bin/python'

filetype plugin on           " allow plugin feature by filetype
filetype indent on           " allow indentation feature by filetype
syntax enable                " enable syntax highlighting
set nobackup                 " don't make a backup before writing a file
set noswapfile               " don't use a swapfile for the buffer
set autowrite                " automatically write modifications to the file on certain commands
set autowriteall             " same as autowrite but on more commands
set history=1000             " keep 1000 lines of history
set encoding=utf-8           " default encoding
set fileformats=unix,dos,mac " default file formats

" keep an undo file
set undofile
if !isdirectory($HOME . "/.cache/nvim/undo")
  call mkdir($HOME . "/.cache/nvim/undo", "p")
endif
set undodir=~/.cache/nvim/undo


" plugins
" see 'lua/plugins.lua'
packadd packer.nvim
lua << EOF
  require('plugins')
  require('lsp_config')
  require('cmp_config')
  require('treesitter_config')
  require('telescope_config')

EOF


"
"--- USER INTERFACE
"
let mapleader=" "              " set the spacebar as <leader> (! use Ctr-V spacebar to insert the space!)
let g:mapleader=" "
set mouse=a                    " allow use of the mouse
set cursorline                 " highlight the line the cursor is on
set ruler                      " always show linenumber/columnnumber of the cursor
set number                     " show line numbers
set signcolumn=yes             " always show the 'sign column' (e.g. to indicate errors)
set laststatus=2               " always show the statusline
set showcmd                    " show incomplete commands
set scrolloff=2                " number of lines to keep above and below the cursor when scrolling vertically
set sidescrolloff=8            " number of columns to keep right and left of the cursor when scrolling horizontally
set wildmenu                   " enhanced command line completion
set wildmode=full              " complete the next full match
set wildignorecase             " ignore case when comleting file names
set wildignore=*.o,*~,*.pyc,*.zip,__pycache__,*/.git/*,*/.hg/*,*/.svn/*    " list of filepatterns to ignore for file completion
set whichwrap+=h,l,<,>         " allow to move over linebreaks
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set fileignorecase             " case insensitive file and directory names
set incsearch                  " start matching the search pattern imediatly
set hlsearch                   " highlight the search pattern
set smartcase                  " case insensitive search except when using an uppercase char
set lazyredraw                 " don't redraw the screen when executing macros
set showmatch                  " show matching pairs of brackets
set matchtime=5                " how long to highlight the pairs of brackets
set noerrorbells               " don't sound the bell on errors
set visualbell                 " just flash the screen
set nojoinspaces               " only insert 1 space after punctuation when joining lines
set formatoptions+=r           " insert current comment leader when hitting <Enter> in insert mode
set formatoptions+=j           " remove comment char when doing automatic formatting (e.g. when joining lines)
set hidden                     " allow hidden buffers (instead of unloading them)
set splitbelow                 " vertical split below the current screen
set splitright                 " horizontal splits to the right
set switchbuf+=useopen         " switch to the first window where the specified buffer is open
set diffopt+=vertical          " prefer vertical splits for diffs
set diffopt+=context:100       " show a lot of context around the changed lines
set autoindent                 " keep indentation of previous line when pressing <Enter>
set smartindent                " be smarter about autoindent
set shiftwidth=4               " shift by 4 spaces when shifting lines with >> or <<
set tabstop=4                  " number of spaces to use for a <Tab>
set softtabstop=4              " number of spaces to use for softtab
set expandtab                  " always expand <Tab> to 4 spaces (don't use <Tab>)
set textwidth=120              " when appropriate, break lines after a maximum width of `textwidth`
set listchars=tab:»·,trail:·   " show these chars for <Tab> and for trailing whitespace
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkon100

"
"--- PLUGINS
"
" powerline + airline
let g:airline_powerline_fonts=1

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_ui_contrast = 'high'
let g:gruvbox_material_cursor='aqua'  " only works in gui client :(
colorscheme gruvbox-material

" telescope plugin (fuzzy finding)
nnoremap <C-p> :Telescope find_files<CR>
nnoremap \ :Telescope live_grep<CR>


" Enable Tab / Shift Tab to cycle completion options
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect


"
"-- KEY MAPPINGS
"

" quite a window
nnoremap <leader>q :q<cr>

" save current buffer (<C-s> gives problems in a normal linux terminal)
nnoremap <leader>w :w!<cr>

" " yank to system clipboard
" nnoremap <leader>y "+y
" " paste from system clipboard
" nmap <leader>p "+p

" " Neat X clipboard integration
" " ,p will paste clipboard into buffer
" " ,c will copy entire buffer into clipboard
" noremap <leader>p :read !xsel --clipboard --output<cr>
" noremap <leader>c :w !xsel -ib<cr><cr>


" make Y behave like C or D
nmap Y y$

" when searching center the search result in center of screen
nmap n nzz
nmap N Nzz

" insert a linebreak
nmap <leader>l i<cr><esc>

" treat long lines as break lines
map j gj
map k gk

" easier way to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" inoremap <C-h> <C-\><C-N><C-w>h
" inoremap <C-j> <C-\><C-N><C-w>j
" inoremap <C-k> <C-\><C-N><C-w>k
" inoremap <C-l> <C-\><C-N><C-w>l

" " and in teminal mode:
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
" tnoremap <Esc> <C-\><C-n>

" Blatantly stolen from https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim

if exists("g:loaded_key_mappings") || &cp || v:version < 700
    finish
endif
let g:loaded_key_mappings = 1

" Next and previous

function! s:MapNextFamily(map,cmd)
    let map = '<Plug>unimpaired'.toupper(a:map)
    let cmd = '".(v:count ? v:count : "")."'.a:cmd
    let end = '"<CR>'.(a:cmd == 'l' || a:cmd == 'c' ? 'zv' : '')
    execute 'nnoremap <silent> '.map.'Previous :<C-U>exe "'.cmd.'previous'.end
    execute 'nnoremap <silent> '.map.'Next     :<C-U>exe "'.cmd.'next'.end
    execute 'nnoremap <silent> '.map.'First    :<C-U>exe "'.cmd.'first'.end
    execute 'nnoremap <silent> '.map.'Last     :<C-U>exe "'.cmd.'last'.end
    execute 'nmap <silent> ['.        a:map .' '.map.'Previous'
    execute 'nmap <silent> ]'.        a:map .' '.map.'Next'
    execute 'nmap <silent> ['.toupper(a:map).' '.map.'First'
    execute 'nmap <silent> ]'.toupper(a:map).' '.map.'Last'
    if exists(':'.a:cmd.'nfile')
        execute 'nnoremap <silent> '.map.'PFile :<C-U>exe "'.cmd.'pfile'.end
        execute 'nnoremap <silent> '.map.'NFile :<C-U>exe "'.cmd.'nfile'.end
        execute 'nmap <silent> [<C-'.a:map.'> '.map.'PFile'
        execute 'nmap <silent> ]<C-'.a:map.'> '.map.'NFile'
    endif
endfunction

" call s:MapNextFamily('a','')  " argument list
call s:MapNextFamily('b','b')  " buffer list
call s:MapNextFamily('l','l')  " local list
call s:MapNextFamily('q','c')  " quickfix list
call s:MapNextFamily('t','t')  " tag stack


" => Nifty trick found at https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" select some text -> replace with "p" without overwritting the paste buffer!
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Define `Reverse`: reverses the order of the lines selected
command! -bar -range=% Reverse <line1>,<line2>global/^/m<line1>-1

" From https://vim.fandom.com/wiki/Pretty-formatting_XML
command! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
command! FormatJson :%!python3 -m json.tool

nmap <leader>b Oimport pudb; pudb.set_trace()  # BREAKPOINT<esc>^
