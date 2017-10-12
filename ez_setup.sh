#!/bin/bash


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
    case $param in
        --vim|--all)
            #Install Pathogen
            sudo apt-get install curl
            mkdir -p ~/.vim/autoload ~/.vim/bundle && \
            curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

            #Install vim.Nerdtree
                # File System navigation in vim
            git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

            #Install vim.supertab 
                # Tab completion for vim.
            git clone https://github.com/ervandew/supertab.git ~/.vim/bundle/supertab

            #Install vim.UndoTree
                # UI for Undo Tree (as in 'control-z' kind of undo)
            git clone https://github.com/mbbill/undotree.git ~/.vim/bundle/undotree

            #Install vim.Tagbar
                # Depends on http://ctags.sourceforge.net/
            git clone https://github.com/majutsushi/tagbar.git ~/.vim/bundle/tagbar
            ;;
        --files|--all)
            #Copy my dotfiles over.
            cp .vimrc ~/.vimrc
            cp .tmux.conf ~/.tmux.conf
            cp .inputrc ~/.inputrc
            cp .profile ~/.profile
            ;;
        --profile)
            echo "source ~/.profile" >> ~/.bash_profile
            source ~/.bash_profile
            ;;
    esac
done
