#!/usr/bin/env bash

$URL="https://github.com/overdrivenpotato/dotfiles"

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

    echo Cloning to $CLONE_DIR
    git clone $URL $CLONE_DIR
    cd $CLONE_DIR
}

finalize() {
    # reset color
    color
}

trap finalize EXIT

if ! type git &>/dev/null; then
    echo Could not find git executable. Necessary for setup.
    exit 2
fi

# Clone repository if not already cloned
[ -d .git ] || clone

color 94
echo Updating git repo... ; git pull origin master ; echo

# Ignore repo files
IGNORE=(.git .gitignore setup.sh backup)
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
# Install NeoBundle
if [[ ! -e ~/.vim/bundle/neobundle.vim ]]; then
    echo Installing NeoBundle...
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

    echo ; echo Installing all vim bundles...
    vim +NeoBundleInstall +qall 2>/dev/null
fi

# Windows handling
if [[ "$(uname -s)" == *"NT"* ]]; then
    mv ~/.vimrc ~/_vimrc
fi

echo 'Done! :)'
source ~/.bashrc
