#!/bin/bash

# vim.plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# git
curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git

# bat
sudo dnf install bat

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

rm "$HOME"/.config/fish/config.fish
ln -s "$PWD"/config.fish "$HOME"/.config/fish/config.fish

echo "source $HOME/dotfiles/bashrc" >> $HOME/.bashrc
