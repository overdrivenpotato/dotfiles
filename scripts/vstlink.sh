#!/usr/bin/env bash

function vstlink {
    if [ ! -f "$1" ]; then
        echo "$1" does not exist
        return
    fi

    local SRC="$(realpath "$1")"
    local DST="$HOME/Library/Audio/Plug-Ins/Vst/vstlink.vst/Contents/MacOS/vstlink"

    echo SRC: $SRC
    echo DST: $DST

    ln -fs "$SRC" "$DST"
}

function _vstlink_unload {
    unset -f vstlink
    unset -f _vstlink_unload
}
