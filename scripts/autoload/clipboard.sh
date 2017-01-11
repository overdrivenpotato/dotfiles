function cbcopy {
    case "$OSTYPE" in
        darwin*)
            pbcopy
            ;;
        linux*)
            xclip
            ;;
        msys*)
            # TODO
            ;;
        *) ;;
    esac
}

function cbpaste {
    case "$OSTYPE" in
        darwin*)
            pbpaste
            ;;
        linux*)
            xclip -o
            ;;
        msys*) ;;
            # TODO
        *) ;;
    esac
}
