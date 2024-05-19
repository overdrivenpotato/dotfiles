#!/usr/bin/env bash

URL="https://github.com/overdrivenpotato/dotfiles"

# No arguments resets to default
function color {
    echo -en "\033[${1:-39}m"
}

function clone {
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

# Reset color
trap color EXIT

if ! type git &>/dev/null; then
    echo Could not find git executable. Necessary for setup.
    exit 2
fi

# Clone repository if not already cloned
[ -d .git ] || clone

# Don't symlink these files
IGNORE=(.git .gitignore .gitmodules setup.sh backup* README.md colors scripts submodules themes)

find_cmd="find . -type f $(printf "! -path './%s*' " "${IGNORE[@]}") | sed 's|^\./||'"
readarray -t FILES < <(eval $find_cmd)

readarray -t BACKUPFILES < <(for f in "${FILES[@]}"; do [[ -e ~/"$f" || -L ~/"$f" ]] && echo "$f"; done)
BACKUPDIR=backup-$(date +%Y%m%d_%H%M%S)

color 91

function prompt {
    echo The following files will move to $(pwd)/$BACKUPDIR

    # List files
    for file in "${BACKUPFILES[@]}"; do
        echo -e "  ~/$file"
    done

    read -p "Continue? [Y to continue] " -r -n 1 ; echo

    if [[ ! $REPLY =~ ^[yY]$ ]]; then
        exit 1
    fi
}

# If any of the repo files already exist, prompt for confirmation
for file in "${BACKUPFILES[@]}"; do
    prompt; break
done

color 33

# Copy if needed to backup and symlink
for file in "${FILES[@]}"; do
    echo Symlinking $file

    # Move the file if it exists and symlink from the setup location
    mkdir -p "$BACKUPDIR/$(dirname "$file")"
    mv ~/"$file" "$BACKUPDIR/$file" 2>/dev/null
    ln -s "$(pwd)/$file" ~/"$file"
done

color 95

echo 'Done! :)'
