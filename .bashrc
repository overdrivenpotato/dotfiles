# Allow for local variables
function _init {
    # All OS
    alias file="file -h"
    stty erase '^?'

    # Local variable
    local COLOR

    # Windows
    if [[ "$(uname -s)" == *"NT"* ]]; then
        export LIBRARY_PATH="C:\\lib\\"
        COLOR="\e[0;31m"
        alias ls="ls --color=auto"
    else # Unix
        # OS X
        if [ "$(uname -s)" = "Darwin" ]; then
            COLOR="\e[0;36m"
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
            COLOR="\e[0;35m"
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

        # Rust source for autocompletion
        if hash rustc 2>/dev/null; then
            local SRC_PATHS=(
                "/usr/local/src/rust/src/"
                "$(rustc --print sysroot)/lib/rustlib/src/rust/"
            )

            for SRC_PATH in ${SRC_PATHS[@]}; do
                if [ -d $SRC_PATH ]; then
                    export RUST_SRC_PATH=$SRC_PATH
                    break
                fi
            done
        fi
    fi

    COLOR="\[$COLOR\]"

    # Switch to prefix if applicable and if in home directory
    local PREFIX=~/Development
    if [[ -d "$PREFIX" && $(pwd) = "$(echo ~)" ]]; then
        cd "$PREFIX"
    fi

    # General
    PS1="$COLOR\w\n$COLOR[\u@\h]\$ \[\e[0m\]"
    PS2="$COLOR> \[\e[0m\]"
} && _init
unset -f _init
