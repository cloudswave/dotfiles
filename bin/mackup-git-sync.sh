#!/bin/sh
DOTFILES_ROOT=~/dotfiles

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# 如果mackup命令不存在，则安装mackup
if ! command -v mackup &> /dev/null; then
  info 'install mackup'
  brew install mackup
fi

# 如果DOTFILES_ROOT不存在，则clone到当前目录
if [ ! -d "$DOTFILES_ROOT" ]; then
  info 'clone dotfiles'
  git clone git@gitcode.net:cloudswave/dotfiles.git $DOTFILES_ROOT
fi
if [ -d "$DOTFILES_ROOT" ]; then
  cd $DOTFILES_ROOT
  info 'pull dotfiles'
  git pull --rebase
  if [ $? -eq 0 ]; then
    success 'pull dotfiles'
  else
    fail 'pull dotfiles'
  fi
  info 'backup dotfiles'
  mackup backup
  git add .
  git commit -m "update dotfiles"
  git push
  if [ $? -eq 0 ]; then
    success 'git push dotfiles'
  else
    fail 'git push dotfiles'
  fi
fi

info 'restore dotfiles'
mackup restore
if [ $? -eq 0 ]; then
  success 'restore dotfiles'
else
  fail 'restore dotfiles'
fi