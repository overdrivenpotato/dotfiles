function ctrlp {
    </dev/tty vim -c CtrlP
}

zle -N ctrlp

if [ $ZSH_VERSION ]; then
    bindkey "^p" ctrlp
fi
