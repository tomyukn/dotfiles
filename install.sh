#!/usr/bin/env bash

set -u

BASEDIR=$(dirname $0)
cd ${BASEDIR}

# .bin
if [ ! -d "${HOME}/bin" ]; then
  mkdir  ${HOME}/bin
fi

# .config
if [ ! -d "${HOME}/.config" ]; then
  mkdir  ${HOME}/.config
fi

# .vim
if [ ! -d "${HOME}/.vim" ]; then
  mkdir  ${HOME}/.vim
fi


ln -snfv ${PWD}/.bash_aliases ~/
ln -snfv ${PWD}/.Renviron ~/
ln -snfv ${PWD}/.Rprofile ~/
ln -snfv ${PWD}/starship.toml ~/.config/
ln -snfv ${PWD}/.vimrc ~/.vim/vimrc
