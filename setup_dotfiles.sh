#!/bin/bash

# get the dir of the dotfiles
dotfiles_dir="$(cd "$(dirname "$0" )" && pwd)"

# common setup
if [[ ! -a ~/.vimrc ]]
then
	ln -s $dotfiles_dir/vim/vimrc.vim ~/.vimrc
fi
