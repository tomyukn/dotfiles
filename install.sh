#!/usr/bin/env bash

set -u

BASEDIR=$(dirname $0)
cd ${BASEDIR}

# .vim
if [ ! -d "${HOME}/.vim" ]; then
  mkdir  ${HOME}/.vim
fi

# link dotfiles
ln -snfv ${PWD}/.bash_aliases ~/
ln -snfv ${PWD}/.gitconfig ~/
ln -snfv ${PWD}/.Renviron ~/
# ln -snfv ${PWD}/.vimrc ~/.vim/vimrc
