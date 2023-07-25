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
