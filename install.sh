#!/bin/bash

backup() {
    if [ -f $1 ]; then
        echo "Backing up $1..."
        mv $1 $1.bak
    fi
}

backup ~/.bashrc
echo "Installing new .bashrc..."
cp .bashrc ~/.bashrc

backup ~/.tmux.conf
echo "Installing new .tmux.conf..."
cp .tmux.conf ~/.tmux.conf

backup ~/.vimrc
echo "Installing new .vimrc..."
cp .vimrc ~/.vimrc

backup ~/.inputrc
echo "Installing new .inputrc..."
cp .inputrc ~/.inputrc

echo "Installing Solarized color scheme..."
mkdir -p ~/.vim/colors
cp solarized.vim ~/.vim/colors

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
