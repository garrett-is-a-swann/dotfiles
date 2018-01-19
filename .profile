# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH

PATH=".:$PATH"
export FORMAT="\nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n"
export EDITOR='vim'


function solo(){
    unset GIT_COMMITTER_NAME
    unset GIT_COMMITTER_EMAIL
}

#pair_up "garrett-is-a-swann" "your@email" && git commit
function pair_up(){
    export GIT_COMMITTER_NAME=$1
    export GIT_COMMITTER_EMAIL=$2
}

# execute commands in a .vim_workspace to generate your default workspace and save time.
# Example:
#   e server.js | tabnew server/routes/api.js | tabnew src/app/app.component.ts | split src/app/app.component.html | tabnew src/app/app.module.ts
alias wsvim='vim -c "$(< .vim_workspace)"'
alias pconn='psql -h localhost -p 5432 -d core -U admin'
