function _unload_powerline_fonts {
    # Remove temporary directory
    rm -rf $_TMP_CLONE

    unset -f powerline_fonts
    unset _TMP_CLONE
}

function powerline_fonts {
    if fc-list | grep -qe 'Powerline.*\.ttf'; then
        return
    fi

    local URL="https://github.com/powerline/fonts"
    _TMP_CLONE="$(mktemp -d -t powerline_fonts.XXX)"

    git clone "$URL" "$_TMP_CLONE/repo"
    "$_TMP_CLONE/repo/install.sh"
}

powerline_fonts
unload powerline_fonts
