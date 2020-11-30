"
"--- PLUGINS
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugs')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'cormacrelf/vim-colors-github'

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'

" Plug 'mileszs/ack.vim'

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Code completion and linting
" Plug 'ervandew/supertab'
" Plug 'w0rp/ale'  " asynchronous linting
" Plug 'Valloric/YouCompleteMe'
" " Plug 'davidhalter/jedi-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Python
Plug 'klen/python-mode'
Plug 'jmcantrell/vim-virtualenv'

Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'

call plug#end()
