function cbcopy {
    echo "calling! args: $1" > /tmp/out.log
    case "$OSTYPE" in
        darwin*)
            pbcopy
            ;;
        linux*)
            echo -n $1 | xclip
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
