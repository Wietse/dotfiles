# dotfiles


## Install

Clone this repository "somewhere" on your machine:

```sh
cd ~
git clone git@github.com:Wietse/dotfiles.git
```

Make sure that `$HOME/.config/nvim` exists:

```sh
mkdir -p $HOME/.config/nvim
```

Create symlinks to the relevant files:

```shell
ln -s $HOME/dotfiles/git/config $HOME/.gitconfig
ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/python/flake8 $HOME/.flake8
ln -s $HOME/dotfiles/neovim/init.vim $HOME/.config/nvim/init.vim
```


### Install neovim

```sh
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
```

This will install neovim to `/usr/local`

For convenience you can:

```sh
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 100
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 100
```

#### For coc with neovim:

Install node.js:

```sh
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g neovim
```

Install a python virtual environment for neovim:

```sh
pyenv virtualenv 3.8.5 neovim-3.8.5
pyenv activate neovim-3.8.5
pip install -U setuptools pip pynvim
```

Install `rust-analyzer`:

```sh
mkdir -p ~/.local/bin
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
```

Now run `nvim` and check the output of `:checkhealth`.
