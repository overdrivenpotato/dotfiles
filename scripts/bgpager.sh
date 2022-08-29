# Custom pager that sets a 24bit RGB background color given by the first
# argument. Note that this should only color transparent backgrounds.
bgpager() {
    if [ ! -t 1 ]; then
        bash -c 'cat'
        return $?
    fi

    echo -n "[48;2;$1m"

    sed "s/\[0m/\[0m\[48;2;$1m/g" \
        | gawk -v cols=$(tput cols) '{
            # Remove carriage returns
            gsub("\r", "", $0);

            # Store the length of $0 (with escape codes removed) in `chars`
            tmp = $0;
            gsub("\x1b\\[[^m]*m", "", tmp);
            chars = length(tmp);

            # Print the string, spaces, and final newline.
            printf "%s", $0;
            for (i = 0; i < cols - chars; ++i) printf " ";
            printf "\n";
        }' \
        | LESSCHARSET=UTF-8 less --mouse --raw-control-chars --quit-if-one-screen --no-init
}
