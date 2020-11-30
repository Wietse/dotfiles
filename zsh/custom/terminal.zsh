alias ~='cd ~'
alias c='clear'
alias cp='cp -iv'  # copy: prompt to overwrite + verbose
alias mv='mv -iv'  # move: prompt to overwrite + verbose
alias mkdir='mkdir -pv'  # make directory: intermediate dirs + verbose
mcd() { mkdir "$1" && cd "$1"; }

alias edit-vimrc='nvim $HOME/.vim/vimrc'
alias edit-zshrc='nvim $HOME/.zshrc'
alias edit-alias='nvim $ZSH_CUSTOM/terminal.zsh'
alias edit-tmuxrc='nvim $HOME/.tmux.conf'
alias edit-gitconfig='nvim $HOME/dotfiles/git/config'

# always getting annoyed with this one...
alias ghostscript='/usr/bin/gs'
alias gs='git status'

# Running the development rust container
dkr-rust() {
docker run -it \
    --rm \
    --mount type=bind,source="$(pwd)",target=/src \
    --user "$(id -u)":"$(id -g)" \
    rustdev
}

# clear the DNS cache on Linux Mint
alias clear-dns-cache='sudo /etc/init.d/dns-clean start'

# open vim in the notes directory
alias notes='nvim ~/Documents/notes'

# show info on hard disks and partitions
alias disk-info='inxi -pod'

# show available colours in the terminal
show-colours () {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
    done
}

# clean up *.pyc files
pyclear () {
    find . -name '*.pyc' -delete
}

alias set-gcc-version='sudo update-alternatives --config gcc'

alias nvpn='nordvpnteams'
