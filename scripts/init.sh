# Set prompt color according to OS
function color {
    if [ $ZSH_VERSION ]; then
        echo "%F{$1}"
    else
        local FORMAT

        if [ $1 = "cyan" ]; then
            FORMAT="36"
        elif [ $1 = "magenta" ]; then
            FORMAT="35"
        elif [ $1 = "red" ]; then
            FORMAT="31"
        elif [ $1 = "default" ]; then
            FORMAT="0"
        fi

        echo "\e[0;${FORMAT}m"
    fi
}

function _init {
    # All OS
    alias c="clear"
    alias gs="git status"
    alias file="file -h"
    alias grep="grep --color"
    stty erase '^?'

    # Local variable
    local COLOR
    local UNAME="$(uname -s)"

    # Windows
    if [[ "$UNAME" == *"NT"* ]]; then
        export LIBRARY_PATH="C:\\lib\\"
        COLOR=$(color red)
        alias ls="ls --color=auto"
    # Unix
    else
        # export TERM=screen-256color
        # alias tmux="tmux -u"
        alias l='ls -alh'

        # OS X
        if [ "$UNAME" = "Darwin" ]; then
            COLOR=$(color cyan)
            alias ls='ls -G'

            export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib
            export ANDROID_HOME=$HOME/Library/Android/sdk
            export NDK_HOME=$ANDROID_HOME/ndk
            export NDK_STANDALONE=$ANDROID_HOME/ndk

            # bash autocomplete
            if [[ $BASH_VERSION  && -f `brew --prefix`/etc/bash_completion ]]; then
                . `brew --prefix`/etc/bash_completion
            fi

            function realpath {
                echo "$(cd "$(dirname "$1")"; pwd)/$(basename $1)"
            }

        # Linux
        elif [ "$UNAME" = "Linux" ]; then
            COLOR=$(color magenta)
            alias ls="ls --color=auto"
            alias open="xdg-open $1 &> /dev/null"

            # Path
            local PREFIX=/media/linport/prefix/bin
            if [ -d "$PREFIX" ]; then
                export PATH=$PATH:$PREFIX
            fi
        fi

        # Array for simple path management
        local PATHS=(
            "$ANDROID_HOME/tools"
            "$ANDROID_HOME/platform-tools"
            "$HOME/.cargo/bin"
            "$HOME/torch/install/bin"
        )

        # Combine
        PATHS=$(printf ":%s" "${PATHS[@]}")
        PATHS=${PATHS:1}

        export PATH="$PATHS:$PATH"

        # Use unified target directory
        export CARGO_TARGET_DIR="$HOME/.target-cargo"

        export PAGER="less --quit-if-one-screen --mouse"

        # Useful functions

        # Make sure loc isn't installed
        if ! hash loc 2>/dev/null; then
            # Lines of code
            # Usage
            #   loc rs
            #   loc rs,js
            #   loc js dirname
            #   loc js,jsx,cjsx dirname
            loc() {
                # Anything followed by a dot, and any one of the
                # comma-delimited filetypes given
                MATCH=".*\.(${1//,/|})$"
                find -E ${2:-.} -regex "$MATCH" | xargs wc -l
            }
        fi

        # Rust source for autocompletion
        command -v exa >/dev/null && unalias l && alias l='exa -laa'

        command -v bat >/dev/null \
            && alias cat='bat' \
            && alias bat='bat --paging=always' \
            && export BAT_PAGER="bash -c \". $DOTFILES/scripts/bgpager.sh; bgpager 26\;37\;42\"" \
            && export BAT_THEME="Obsidian"

        command -v nvim >/dev/null && alias vim='nvim'
    fi

    DEV_HOME=$HOME/Development
    if [[ -d "$DEV_HOME" && "$(pwd)" = "$HOME" ]]; then
        cd "$DEV_HOME"
    fi

    # General
    if [ $BASH_VERSION ]; then
        PS1="$COLOR\w\n$COLOR[\u@\h]\$ \[\e[0m\]"
        PS2="$COLOR> \[\e[0m\]"
    elif [ $ZSH_VERSION ]; then
        PS1="${COLOR}%~"$'\n'"${COLOR}[%n@%m]%# `color default`"
        PS2="${COLOR}> `color default`"
    fi
}

_init

unset -f color
unset -f _init
