#!/usr/bin/env bash

function vstlink {
    local SRC="$(realpath "$1")"
    local DST="$HOME/Library/Audio/Plug-Ins/Vst/vstlink.vst/Contents/MacOS/vstlink"

    echo SRC: $SRC
    echo DST: $DST

    ln -fs "$SRC" "$DST"
}
