#!/bin/bash

cp ~/.vimrc .
cp ~/.tmux.conf .
cp ~/.inputrc .
cp ~/.profile .
git add .profile
git add .vimrc
git add .tmux.conf
git add .inputrc

git add ez_setup.sh
git add update.sh
