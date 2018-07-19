#!/bin/bash

cp ~/.vimrc .
cp ~/.tmux.conf .
cp ~/.tmux.conf.local .
cp ~/.inputrc .
cp ~/.profile .
git add .profile
git add .vimrc
git add .tmux.conf
git add .inputrc
git add .tmux.conf.local

git add ez_setup.sh
git add update.sh
