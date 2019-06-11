# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v

# Remove the escape binding and replace it with `jk`.
bindkey -M viins 'jk' vi-cmd-mode
bindkey -r 

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Reverse tab
bindkey '^Y' reverse-menu-complete

# Set up standard shell
source ~/.shellrc

source $DOTFILES/submodules/antigen/antigen.zsh

# Antigen
antigen apply
antigen bundle zsh-users/zsh-autosuggestions
