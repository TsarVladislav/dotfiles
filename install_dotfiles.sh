#!/bin/bash

# скачать vim.plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.vim/colors
cd ~/.vim/colors/
wget https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim
