# Custom pager that sets a 24bit RGB background color given by the first
# argument. Note that this should only color transparent backgrounds.
bgpager() {
    local e=$'\033'
    local bg="$e[48;2;$1m"

    sed -E "
        # Write initial bg color
        1s/^/$bg/

        # Extend color to line ends
        s/($e\[48;2;[0-9;]+m)?($e\[0K)?($e\[(0)?m)?$/$bg\1$e[0K\3/

        # Append resets within line with bg color
        s/($e\[(0)?m)/\1$bg/g;
    " | \
    LESSCHARSET=UTF-8 LESSANSIENDCHARS=mK less --mouse --raw-control-chars --quit-if-one-screen
}
