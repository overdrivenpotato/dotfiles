# The variable is reset here as setting it inline in the tmux config does not
# work. It is also faster to call this script manually rather than sourcing
# .bashrc every time so we set $DOTFILES again
DOTFILES=$(dirname $(readlink $HOME/.tmux.conf))
source $DOTFILES/scripts/autoload/clipboard.sh
cbcopy
