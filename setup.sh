#!/usr/bin/env bash

# No arguments resets to default
function color {
    echo -en "\033[${1:-39}m"
}

function _clone {
    color 92

    CLONE_DIR="$HOME/dotfiles"

    # Allow the user to change the dotfiles directory
    echo Current dotfiles directory: $CLONE_DIR
    echo [enter path or press enter to continue]:

    read -e
    # If the string is not empty
    if [ ! -z $REPLY ]; then
        CLONE_DIR=$REPLY
    fi

    if [ -d "$CLONE_DIR" ]; then
        echo Directory "$CLONE_DIR" already exists. Failed to clone repository.
        exit 2
    fi

    echo Cloning to "$CLONE_DIR"
    git clone $URL "$CLONE_DIR"
    cd "$CLONE_DIR"
}

function _finalize {
    # Reset color
    # TODO: Use a seperate module
    echo -en "\033[39m"

    # Clean up
    unset -f color
    unset -f _clone
    unset -f _setup
}

function _setup {
    local URL="https://github.com/overdrivenpotato/dotfiles"

    trap _finalize EXIT

    if ! type git &>/dev/null; then
        echo Could not find git executable. Necessary for setup.
        exit 2
    fi

    # Clone repository if not already cloned
    [ -d .git ] || _clone

    color 94
    echo Updating git repo... ; git pull origin master ; echo

    # Don't symlink these files
    IGNORE=(.git .gitignore setup.sh backup README.md colors scripts submodules)
    FILES=(
        $(ls -A | sed -e `echo ${IGNORE[@]} | xargs -n1 printf "/^%s$/d;"`)
    )

    color 91
    function prompt {
        echo The following files will move to $(pwd)/backup/

        # List files
        for file in ${FILES[@]}; do
            if [[ -e ~/$file || -L ~/$file ]]; then
                echo -e "  ~/$file"
            fi
        done

        read -p "Continue? [Y to continue] " -r -n 1 ; echo

        if [[ ! $REPLY =~ ^[yY]$ ]]; then
            exit 1
        fi
    }

    # If any of the repo files already exist, prompt for confirmation
    for file in ${FILES[@]}; do
        if [[ -e ~/$file || -L ~/file ]]; then
            prompt ; mkdir -p backup ; break
        fi
    done

    color 33
    # Copy if needed to backup and symlink
    for file in ${FILES[@]}; do
        echo Symlinking $file

        # Move the file if it exists and symlink from the setup location
        rm -rf backup/$file
        mv ~/$file backup 2>/dev/null
        ln -s "$(pwd)/$file" ~/$file
    done

    color 95



    source ~/.bashrc
    load powerline-fonts

    echo 'Done! :)'
}

_setup
