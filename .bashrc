# All OS
alias file="file -h"
stty erase '^?'

# Windows
if [[ "$(uname -s)" == *"NT"* ]]; then
    export LIBRARY_PATH="C:\\lib\\"
    color="\e[0;31m"
    alias ls="ls --color=auto"
else # Unix
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
        alias open="xdg-open $1 &> /dev/null"

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
        "$(yarn global bin 2>/dev/null)"
    )

    # Combine
    PATHS=$(printf ":%s" "${PATHS[@]}")
    PATHS=${PATHS:1}

    export PATH="$PATHS:$PATH"

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

    # Rust
    USRLOCAL="/usr/local/src/rust/src"
    if hash rustup 2>/dev/null; then
        export RUST_SRC_PATH="$(\
            # Fetch the default toolchain folder
            rustup which rustc 2>/dev/null | sed 's/\/bin\/rustc$//g'\
            # Tack on src location
            )/lib/rustlib/src/rust/"
    elif [ -d $USRLOCAL ]; then
        # Work with manual/legacy path
        export RUST_SRC_PATH=$USRLOCAL
    fi
fi

color="\[$color\]"

# Switch to prefix if applicable and if in home directory
PREFIX=~/Development
if [[ -d "$PREFIX" && $(pwd) = "$(echo ~)" ]]; then
    cd "$PREFIX"
fi

# General
PS1="$color\w\n$color[\u@\h]\$ \[\e[0m\]"
PS2="$color> \[\e[0m\]"
