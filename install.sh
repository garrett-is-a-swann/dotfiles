#!/bin/bash

# nerdtree: File System navigation in vim
# supertab: fun tab completion for vim.
# undotree: UI for vim's Undo Tree (as in 'control-z' kind of undo)
# tagbar: depends on http://ctags.sourceforge.net/
# vim-fugitive: Git integration with Vim
# vim-commentary: Quick commenting sections
vim_plugins="scrooloose/nerdtree.git ervandew/supertab.git mbbill/undotree.git majutsushi/tagbar.git"
vim_plugins="$vim_plugins tpope/vim-fugitive.git tpope/vim-commentary.git"

function installVimPlugins() {
    echo 'Installing Vim Plugins...'

    echo 'Install curl/pathogen'
    #Install Pathogen
    sudo apt-get install curl
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


    for i in $(sed -r 's/ /\n/g' <<< "$vim_plugins"); do
        echo "git clone https://github.com/$i ~/.vim/bundle$(sed -r 's/[^\/]*(.*).git/\1/' <<< $i)"
        git clone git@github.com:$i ~/.vim/bundle$(sed -r 's/[^\/]*(.*).git/\1/' <<< $i)
    done
}

function installBashProfile() {
    echo "source ~/.profile" >> ~/.bash_profile
    source ~/.bash_profile
}

function installDotFiles() {
    echo "Installing dotfiles"
    #Copy dotfiles over.
    cp .vimrc ~/.vimrc
    cp .tmux.conf ~/.tmux.conf
    cp .tmux.conf.local ~/.tmux.conf.local
    cp .inputrc ~/.inputrc
    cp .profile ~/.profile
}

if [ $# -eq 0 ]
then
    printf "$0 parameters:\n\t--all -- Do errything (except --profile)\n"
    printf "\t--vim -- install vim plugins\n"
    printf "\t--files -- copy dotfiles into home dir\n"
    printf "\t--profile -- 'echo \"source ~/.profile\" >> ~/.bash_profile'\n"
    exit 1
fi
for param in "$@"
do
    case $param in --all)
        installVimPlugins
        installDotFiles
        ;;
    esac
    case $param in --vim)
        installVimPlugins
        ;;
    esac
    case $param in --profile)
        installBashProfile
        ;;
    esac
    case $param in --files)
        installDotFiles
        ;;
    esac
done
