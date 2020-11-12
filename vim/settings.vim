"
"--- GENERAL
"
set nocompatible             " not vi-compatible
filetype plugin on           " allow plugin feature by filetype
filetype indent on           " allow indentation feature by filetype
syntax enable                " enable syntax highlighting
set nobackup                 " don't make a backup before writing a file
set noswapfile               " don't use a swapfile for the buffer
set history=1000             " keep 1000 lines of history
set encoding=utf-8           " default encoding
set fileformats=unix,dos,mac " default file formats

" keep an undo file
set undofile
if !isdirectory($HOME . "/.vim/.undo")
  call mkdir($HOME . "/.vim/.undo", "p")
endif
set undodir=~/.vim/.undo

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
" set cmdheight=2                " height of cmdline
set showcmd                    " show incomplete commands
set scrolloff=2                " number of lines to keep above and below the cursor when scrolling vertically
set sidescrolloff=8            " number of columns to keep right and left of the cursor when scrolling horizontally
set wildmenu                   " enhanced command line completion
set wildmode=full              " complete the next full match
set wildignorecase             " ignore case when comleting file names
set wildignore=*.o,*~,*.pyc,*.zip,__pycache__    " list of filepatterns to ignore for file completion
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
set completeopt=menuone,longest        " also show the menu when there is only 1 match
                                       " only insert the longest common text of the matches
set autoindent                 " keep indentation of previous line when pressing <Enter>
set smartindent                " be smarter about autoindent
set shiftwidth=4               " shift by 4 spaces when shifting lines with >> or <<
set tabstop=4                  " number of spaces to use for a <Tab>
set softtabstop=4              " number of spaces to use for softtab
set expandtab                  " always expand <Tab> to 4 spaces (don't use <Tab>)
set textwidth=120              " when appropriate, break lines after a maximum width of `textwidth`
set nowrap                     " don't wrap long lines
set list                       " enable list mode to show invisible characters
set listchars=tab:»·,trail:·   " show these chars for <Tab> and for trailing whitespace
set updatetime=100             " some plugins hook into the CursorHold event which gets triggered after updatetime ms

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block " in gui and win32 console
if exists('$TMUX')                                               " if in tmux
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[1 q\<Esc>\\"
    endif
elseif &term == 'xterm-256color' || &term == 'screen-256color'   " in the terminal
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

"From https://github.com/aonemd/aaku
"remove current line highlight in unfocused window
augroup window_focus
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter * set cursorline
    autocmd WinLeave,FocusLost,CmdwinLeave * set nocursorline
augroup END

"netrw
let g:netrw_banner=1
let g:netrw_winsize=30
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_localrmdir='rm -r'
nnoremap <leader>e :Lexplore<CR>
augroup filetype_netrw
    autocmd!
    autocmd FileType netrw set nolist
augroup END

"
"--- SPECIFIC FILE TYPES
"

" For VIM, HTML, XML, CSS I want only 2 space indents
augroup filetype_2space_indent
    autocmd!
    autocmd BufRead,BufNewFile *.vim,*.htm,*.html,*.xml,*.css set shiftwidth=2
    autocmd BufRead,BufNewFile *.vim,*.htm,*.html,*.xml,*.css set tabstop=2
    autocmd FileType sh,groovy set sw=2
    autocmd FileType sh,groovy set ts=2
augroup END

" Makefile does need tabs
augroup filetype_make
    autocmd!
    autocmd BufRead,BufNewFile Makefile* set noexpandtab
augroup END

augroup filetype_jenkinsfile
    autocmd!
    autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy
augroup END

"
"--- MISCELANIOUS
"

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

if executable('rg')
  " use ripgrep to grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  " Use the Silver Searcher to grep, if available
  set grepprg=ag\ --nogroup\ --nocolor
endif
