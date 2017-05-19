#!/bin/bash

echo "Backing up .bashrc..."
mv ~/.bashrc ~/.bashrc.bak
echo "Installing new .bashrc..."
cp .bashrc ~/.bashrc

echo "Backing up .tmux.conf..."
mv ~/.tmux.conf ~/.tmux.conf.bak
echo "Installing new .tmux.conf..."
cp .tmux.conf ~/.tmux.conf

echo "Backing up .vimrc..."
mv ~/.vimrc ~/.vimrc.bak
echo "Installing new .vimrc..."
cp .vimrc ~/.vimrc

[[ -d ~/.vim/bundle/Vundle.vim ]] ||
(
    echo "Downloading Vundle..."
    mkdir -p ~/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
)
echo "Installing Vim plugins..."
vim -c 'VundleInstall' -c 'qa!'

echo "Installing nginx Vim syntax file..."
mkdir -p ~/.vim/syntax
cp nginx.vim ~/.vim/syntax

[[ ! -f ~/.vim/filetype.vim ]] || (! grep -q nginx ~/.vim/filetype.vim) &&
(
    echo "Adding nginx detection to filetype.vim..."
    echo "au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif" >> ~/.vim/filetype.vim
)

#shellcheck source=/dev/null
source ~/.bashrc
