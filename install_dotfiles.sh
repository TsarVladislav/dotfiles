#!/bin/bash

# vim.plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# git
curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git

# bat
sudo dnf -y install bat

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

rm -f "$HOME"/.vimrc
ln -sf "$PWD"/.vimrc "$HOME"/.vimrc

rm -f "$HOME"/.tmux.conf
ln -sf "$PWD"/.tmux.conf "$HOME"/.tmux.conf

# bat
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat

# fish
sudo dnf -y install fish

rm -f "$HOME"/.config/fish/config.fish
mkdir -p "$HOME"/.config/fish/

ln -sf "$PWD"/config.fish "$HOME"/.config/fish/config.fish

echo "source $HOME/dotfiles/bashrc" >> $HOME/.bashrc


# install and update plugins
vim +PluginUpdate +qall

# theme

cp -r $HOME/.vim/plugged/gruvbox/autoload/* $HOME/.vim/autoload/
cp -r $HOME/.vim/plugged/gruvbox/colors/* $HOME/.vim/colors/
