set runtimepath^=~/dotfiles/vim runtimepath+=~/dotfiles/vim/after
let &packpath = &runtimepath
source ~/dotfiles/vim/vimrc

let g:python3_host_prog = '/home/wja/.pyenv/versions/neovim-3.8.5/bin/python'
