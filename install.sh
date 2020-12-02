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

# starship
if [ ! -f "${HOME}/bin/starship" ]; then
  curl -fsSL https://starship.rs/install.sh | bash -s -- -f -b ${HOME}/bin
fi

# vim-plug
if [ ! -f "${HOME}/.vim/autoload/plug.vim" ];then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


ln -snfv ${PWD}/.bash_aliases ~/
ln -snfv ${PWD}/.Renviron ~/
ln -snfv ${PWD}/.Rprofile ~/
ln -snfv ${PWD}/starship.toml ~/.config/
ln -snfv ${PWD}/.vimrc ~/.vim/vimrc
