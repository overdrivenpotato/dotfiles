# All OS
alias file="file -h"
stty erase '^?'

# Windows
if [[ "$(uname -s)" == *"NT"* ]]; then
    export LIBRARY_PATH="C:\\lib\\"
    color="\e[0;31m"
    alias ls="ls --color=auto"
else # Unix
    # Rust
    export RUST_SRC_PATH=/usr/local/src/rust/

    # Useful functions

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

    # OS X
    if [ "$(uname -s)" = "Darwin" ]; then
        color="\e[0;36m"
        alias ls='ls -G'

        export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib/
        export ANDROID_HOME=~/Library/Android/sdk
        export NDK_HOME=$ANDROID_HOME/ndk/
        export NDK_STANDALONE=$ANDROID_HOME/ndk/

        # git autocomplete
        if [ -f `brew --prefix`/etc/bash_completion ]; then
            . `brew --prefix`/etc/bash_completion
        fi

    # Linux
    elif [ "$(uname -s)" = "Linux" ]; then
        color="\e[0;35m"
        alias ls="ls --color=auto"
        alias open="xdg-open $1 > /dev/null 2>&1"

        # Path
        PREFIX=/media/linport/prefix/bin
        if [ -d "$PREFIX" ]; then
            export PATH=$PATH:$PREFIX
        fi
    fi

    # Array for simple path management
    PATHS=(
        "$ANDROID_HOME/tools/"
        "$ANDROID_HOME/platform-tools/"
        "$HOME/.cargo/bin"
        "$HOME/torch/install/bin"
        "$(yarn global bin)"
    )

    # Combine
    PATHS=$(printf ":%s" "${PATHS[@]}")
    PATHS=${PATHS:1}

    export PATH="$PATHS:$PATH"
fi

color="\[$color\]"

# Switch to prefix if applicable
PREFIX=~/Development
if [ -d "$PREFIX" ]; then
    cd "$PREFIX";
fi

# General
PS1="$color\w\n$color[\u@\h]\$ \[\e[0m\]"
PS2="$color> \[\e[0m\]"
