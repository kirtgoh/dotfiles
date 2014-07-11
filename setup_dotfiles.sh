#!/bin/bash

# get the dir of the dotfiles
dotfiles_dir="$(cd "$(dirname "$0" )" && pwd)"

# common setup
if [[ ! -a ~/.vimrc ]]
then
	ln -s $dotfiles_dir/vim/vimrc.vim ~/.vimrc
fi

if [[ ! -a ~/.gitignore_global ]]
then
	ln -s $dotfiles_dir/misc/gitignore_global ~/.gitignore_global
fi

# Private UltiSnips folder setup
if [[ ! -a ~/.vim/UltiSnips ]]
then
	ln -s $dotfiles_dir/vim/UltiSnips ~/.vim/UltiSnips
fi

source $dotfiles_dir/gitconfig_setup.sh
