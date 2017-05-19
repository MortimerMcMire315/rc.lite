#!/bin/bash

cp .bashrc ~/.bashrc
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c 'VundleInstall' -c 'qa!'
mkdir -p ~/.vim/syntax
cp nginx.vim ~/.vim/syntax
echo "au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif" >> ~/.vim/filetype.vim
source ~/.bashrc
