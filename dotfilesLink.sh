#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

ln -sf $SCRIPT_DIR/.gitconfig ~/.gitconfig
ln -sf $SCRIPT_DIR/.dein.toml ~/.dein.toml
ln -sf $SCRIPT_DIR/.bash_profile ~/.bash_profile
ln -sf $SCRIPT_DIR/.bashrc ~/.bashrc
ln -sf $SCRIPT_DIR/.zshrc ~/.zshrc
# ln -sf $SCRIPT_DIR/.vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/config/nvim ~/.config/nvim
ln -sf $SCRIPT_DIR/.tmux.conf ~/.tmux.conf
