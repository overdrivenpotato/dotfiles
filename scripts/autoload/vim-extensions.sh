function ctrlp {
    </dev/tty vim -c CtrlP
}

if [ $ZSH_VERSION ]; then
    bindkey "^p" ctrlp
    zle -N ctrlp
fi
