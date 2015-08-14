# All OS
alias file="file -h"

# Windows
if [[ "$(uname -s)" == *"NT"* ]]; then
    export LIBRARY_PATH="C:\\lib\\"
    terminal_color="\e[0;31m"
    alias ls="ls --color=auto"
else # Unix
    # Rust
    export RUST_SRC_PATH=/usr/local/src/rust/
    export PATH=$PATH:~/.android-sdk/platform-tools/

    # OS X
    if [ "$(uname -s)" = "Darwin" ]; then
        terminal_color="\e[0;36m"
        alias ls='ls -G'
        export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib/

        # git autocomplete
        if [ -f `brew --prefix`/etc/bash_completion ]; then
            . `brew --prefix`/etc/bash_completion
        fi

    # Linux
    elif [ "$(uname -s)" = "Linux" ]; then
        terminal_color="\e[0;35m"
        alias ls="ls --color=auto"
        alias open="xdg-open $1 > /dev/null 2>&1"
    fi
fi

# General
PS1="\[$terminal_color\]\w\n[\u@\h]\$ \[\e[0m\]"
PS2="\[$terminal_color\]> \[\e[0m\]"
