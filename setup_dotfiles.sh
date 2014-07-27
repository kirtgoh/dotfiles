#!/bin/bash

# get the dir of the dotfiles
dotfiles_dir="$(cd "$(dirname "$0" )" && pwd)"

# common setup
if [[ ! -a ~/.vimrc ]]
then
	ln -s $dotfiles_dir/vim/vimrc.vim ~/.vimrc
fi

if [[ ! -a ~/.gdbrc ]]
then
  ln -s $script_dir/misc/gdbrc ~/.gdbrc
fi

if [[ ! -a ~/.cgdb/cgdbrc ]]
then
  mkdir ~/.cgdb
  ln -s $script_dir/misc/cgdbrc ~/.cgdb/cgdbrc
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

if [[ ! -a ~/.latexmkrc ]]
then
	ln -s $dotfiles_dir/misc/latexmkrc.unix ~/.latexmkrc
fi

# -p says to create the dir if it doesn't exist already
mkdir -p $HOME/tmp/vim

platform=$(uname)

# Naturally, macvim needs to be installed for this to work
if [[ $platform == *Darwin* ]]
then
  # symlinks for mvim
  if [[ -a ~/bin/mvim ]]
  then
    ln -s ~/bin/mvim ~/bin/gvimdiff
    ln -s ~/bin/mvim ~/bin/vimdiff
    ln -s ~/bin/mvim ~/bin/vim
    ln -s ~/bin/mvim ~/bin/gvim
    ln -s ~/bin/mvim ~/bin/vi
  else
    ln -s /usr/local/bin/mvim ~/bin/gvimdiff
    ln -s /usr/local/bin/mvim ~/bin/vimdiff
    ln -s /usr/local/bin/mvim ~/bin/vim
    ln -s /usr/local/bin/mvim ~/bin/gvim
    ln -s /usr/local/bin/mvim ~/bin/vi
  fi
fi

source $dotfiles_dir/gitconfig_setup.sh
