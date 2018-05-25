#!/bin/bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
#if [ -n "$BASH_VERSION" ]; then
    ## include .bashrc if it exists
    #if [ -f "$HOME/.bashrc" ]; then
	#. "$HOME/.bashrc"
    #fi
#fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH

PATH=".:$PATH"
export FORMAT="\nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n"

export EDITOR="/usr/bin/vim"

function solo(){
    unset GIT_COMMITTER_NAME
    unset GIT_COMMITTER_EMAIL
}

#pair_up "garrett-is-a-swann" "your@email" && git commit
function pair_up(){
    export GIT_COMMITTER_NAME=$1
    export GIT_COMMITTER_EMAIL=$2
}

function sean_commit(){
    if [ $# -eq 0 ]
    then
        echo "Send in with commit message"
        exit 1
    fi
    export GIT_COMMITTER_NAME="garrett-is-a-swann"
    export GIT_COMMITTER_EMAIL="sean_pimentel@hotmail.com"
    git commit -m $!
    unset GIT_COMMITTER_NAME
    unset GIT_COMMITTER_EMAIL
}


function pconn_func(){
    while [ -z "$PCONNPASS" ]; do
        looper=1;
        printf "Enter your db pass pls: "
        read -s PCONNPASS
        export PCONNPASS
        PGPASSWORD=$PCONNPASS psql -h localhost -p 5432 -d core -U admin $*
        if [ $? -eq 2 ]; then
            unset PCONNPASS
        fi
    done 
    if [ -z "$looper" ]; then 
        PGPASSWORD=$PCONNPASS psql -h localhost -p 5432 -d core -U admin $*
    fi
    unset looper
}
function docker_conn(){
    docker exec -it $1 bash
}

alias memes='memes'

alias wsvim='vim -c "$(< .vim_workspace)"'
alias dps='docker ps --format=$FORMAT'
alias dconn='docker_conn $1'
alias pconn='pconn_func'
alias sound='alsamixer'
alias wwwpg='~/codeplay/www/node_modules/.bin/sequelize'
