#!/bin/bash

git config --global user.name "kirtgoh"

current_email=$(git config --global --get user.email)

# if current_email is empty, then add an email
if [[ -z "$current_email" ]]
then
    git config --global user.email "kirtgoh@gmail.com"
fi

git config --global github.user kirtgoh 

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.h help
git config --global alias.unstage "reset HEAD"
git config --global alias.unstash "stash pop"

git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

git config --global color.ui true

git config --global core.excludesfile ~/.gitignore_global
git config --global core.autocrlf false

