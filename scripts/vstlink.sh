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

function _unload_vstlink {
    unset -f vstlink
}
