#!/usr/bin/env bash

DOTFILES=$(dirname $(readlink $HOME/.bashrc))

function load {
    for NAME in "$@"; do
        local SEARCH=(
            "$DOTFILES/scripts/$NAME.sh"
            "$DOTFILES/scripts/autoload/$NAME.sh"
            "$NAME"
        )

        for SCRIPT in ${SEARCH[@]}; do
            if [ -f "$SCRIPT" ]; then
                source "$SCRIPT"
                break
            fi
        done
    done
}

# Load initialization script first
load init

# Load the autoload scripts next
load "$DOTFILES/scripts/autoload/*.sh"
