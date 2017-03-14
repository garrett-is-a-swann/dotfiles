#!/bin/bash

#Install Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#Install vim.Nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#Install vim.UndoTree
git clone https://github.com/mbbill/undotree.git ~/.vim/bundle/undotree

#Copy my dotfiles over.
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf
