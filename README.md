# dotfiles

## Install

Clone this repository "somewhere" on your machine.
Next clone the powerlevel9k theme for zsh:
```shell
git clone https://github.com/bhilburn/powerlevel9k.git ~/.dotfiles/zsh/custom/themes/powerlevel9k
```
Then create symlinks to the relevant files:

```shell
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/git/config ~/.gitconfig
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
```

## Note: Mac os x zsh install with homebrew
You will need to add `/usr/local/bin/zsh` to the list of shells in `/ets/shells` (use `sudo vim /etc/shells`).
For the powerlevelk9 theme you also need to install some fonts:
```shell
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
```
