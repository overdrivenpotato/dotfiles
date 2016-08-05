#!/usr/bin/env bash

URL="https://github.com/overdrivenpotato/dotfiles"

# No arguments resets to default
color() {
    echo -en "\033[${1:-39}m"
}

clone() {
    CLONE_DIR="$HOME/dotfiles"

    if [ -d "$CLONE_DIR" ]; then
        echo Directory "$CLONE_DIR" already exists. Failed to clone repository.
        exit 2
    fi

    echo Cloning to "$CLONE_DIR"
    git clone $URL "$CLONE_DIR"
    cd "$CLONE_DIR"
}

finalize() {
    # reset color
    color
}

trap finalize EXIT

# Get vim dir location
VIM_FILES="$HOME/.vim"
VIM_DIRS=(
    "$HOME/vimfiles"
)

if [ ! -d "$VIM_FILES" ]; then
    for dir in ${VIM_DIRS[@]}; do
        if [ -d "$dir" ]; then
            VIM_FILES="$dir"
        fi
    done
fi

if ! type git &>/dev/null; then
    echo Could not find git executable. Necessary for setup.
    exit 2
fi

# Clone repository if not already cloned
[ -d .git ] || clone

color 94
echo Updating git repo... ; git pull origin master ; echo

# Ignore repo files
IGNORE=(.git .gitignore setup.sh backup README.md)
FILES=(
    $(ls -A | sed -e `echo ${IGNORE[@]} | xargs -n1 printf "/^%s$/d;"`)
)

color 91
function prompt {
    echo The following files will move to ./backup/

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
    ln -s "$(cd `dirname "${BASH_SOURCE}"` ; pwd)/$file" ~/$file
done

color 95
# Install vim-plug
VIM_PLUG="$VIM_FILES/vim-plug/autoload"
if [[ ! -e "$VIM_PLUG" ]]; then
    echo Installing plugin manager...
    mkdir -p "$VIM_PLUG"
    git clone https://github.com/junegunn/vim-plug "$VIM_PLUG"
fi

echo Installing all vim bundles...
vim "+silent PlugInstall" "+qall"

# Windows handling
if [[ "$(uname -s)" == *"NT"* ]]; then
    mv ~/.vimrc ~/_vimrc
fi

echo 'Done! :)'
source ~/.bashrc
