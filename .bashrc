# All OS
alias file="file -h"

# Windows
if [[ "$(uname -s)" == *"NT"* ]]; then
    export LIBRARY_PATH="C:\\lib\\"
    color="\e[0;31m"
    alias ls="ls --color=auto"
else # Unix
    # Rust
    export RUST_SRC_PATH=/usr/local/src/rust/
    export PATH=$PATH:~/sdks/android-sdk-macosx/platform-tools/

    # Useful functions
    loc() { # lines of code
        find ${2:-.} -name "*.${1:-*}" | xargs wc -l
    }

    # OS X
    if [ "$(uname -s)" = "Darwin" ]; then
        color="\e[0;36m"
        alias ls='ls -G'

        export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib/
        export CARGO_INSTALL_ROOT=/usr/local/bin
        export ANDROID_HOME=~/sdks/android-sdk-macosx/
        export NDK_HOME=~/sdks/android-sdk-macosx/ndk/
        export NDK_STANDALONE=~/sdks/android-sdk-macosx/ndk/

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
fi

color="\[$color\]"

# General
PS1="$color\w\n$color[\u@\h]\$ \[\e[0m\]"
PS2="$color> \[\e[0m\]"
