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
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'  " asynchronous linting
Plug 'klen/python-mode'
Plug 'jmcantrell/vim-virtualenv'
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'Shougo/deoplete.nvim'  " asynchronous completion
" Plug 'roxma/nvim-yarp'  " deoplete dependency
" Plug 'roxma/vim-hug-neovim-rpc'  " deoplete dependency
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
" Plug 'davidhalter/jedi-vim'
Plug 'mileszs/ack.vim'
Plug 'rust-lang/rust.vim'
call plug#end()
