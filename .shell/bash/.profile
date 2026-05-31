#!/usr/bin/env bash

#######   ALIASES   ############################################################
source "$HOME/.shell/common/alias"
if [ -f "$HOME/.shell/bash/alias" ]; then
  source "$HOME/.shell/bash/alias"
fi

#######   FUNCTIONS   ##########################################################
# Load shared functions
for FUNCTIONS in "$HOME"/.shell/common/functions/*; do
  [ -e "$FUNCTIONS" ] || continue
  source "$FUNCTIONS"
done

# Load Bash-specific functions
for FUNCTIONS in "$HOME"/.shell/bash/functions/*; do
  [ -e "$FUNCTIONS" ] || continue
  source "$FUNCTIONS"
done

#######   COMPLETIONS   ########################################################
for SCRIPT in "$HOME"/.shell/bash/completions/*; do
  [ -e "$SCRIPT" ] || continue
  source "$SCRIPT"
done

########   SOURCES / VARS  #####################################################
PATH=$PATH:$HOME/bin:$HOME/.shell/bin

#Set File Colors
# Get the aliases and functions
if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

#Set File Colors
export CLICOLOR=1

#######   APP CONFIG   #########################################################

#######   BREW   ###############################################################
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

#######   DIRENV   #############################################################
if [[ -x "$(command -v direnv)" ]]; then
  eval "$(direnv hook bash)"
fi

#######   FZF   ################################################################
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

#######   VIM   ################################################################
export VISUAL="$(which vim)"
export EDITOR="$VISUAL"
