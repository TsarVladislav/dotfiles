#!/bin/bash

# vim.plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

rm "$HOME"/.vimrc
ln -s "$PWD"/.vimrc "$HOME"/.vimrc

rm "$HOME"/.tmux.conf
ln -s "$PWD"/.tmux.conf "$HOME"/.tmux.conf

# bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

echo "source $HOME/dotfiles/bashrc" >> $HOME/.bashrc
