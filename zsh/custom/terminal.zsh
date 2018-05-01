alias ~='cd ~'
alias c='clear'
alias cp='cp -iv'  # copy: prompt to overwrite + verbose
alias mv='mv -iv'  # move: prompt to overwrite + verbose
alias mkdir='mkdir -pv'  # make directory: intermediate dirs + verbose
mcd() { mkdir "$1" && cd "$1"; }

alias edit-vimrc='vim ~/.vim/vimrc'
alias edit-zshrc='vim ~/.zshrc'
alias edit-alias='vim ~/.oh-my-zsh/custom/terminal.zsh'
alias edit-tmuxrc='vim ~/.tmux.conf'

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
alias notes='cd ~/Documents/notes && vim .'

# show info on hard disks and partitions
alias disk-info='inxi -pod'
