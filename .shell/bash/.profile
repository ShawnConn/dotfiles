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

# Configure Go Paths
export GOROOT=$(brew --prefix go 2> /dev/null)
export GOROOT=/opt/homebrew/opt/go/libexec
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Configure Cargo Path
export PATH=$PATH:$HOME/.cargo/bin

# Configure Java Path
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# Configure Ruby Path
export RUBYROOT=$(gem env | grep "USER INSTALLATION DIRECTORY" | cut -d':' -f2 | xargs)
export PATH="$RUBYROOT/bin:$PATH"

# Configure Python/pipx Path
if [[ -x "$(command -v pipx)" ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Add Custom Project Config in "$HOME/.projects/*/config"
if [ -d "$HOME/.projects/" ]; then
  PROJECTS=$(find "$HOME/.projects/" -type d -maxdepth 1 -mindepth 1 | sort)
  while IFS= read -r PROJECT; do
    if [ -f "$PROJECT/config" ]; then
      source "$PROJECT/config"
    fi
  done <<< "$PROJECTS"
fi

# Export / File Mask
export PATH
umask 007

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

#######   ORACLE   #############################################################
# Setup Oracle Environment If Installed
if [ -d /usr/lib/oracle/instantclient ]; then
  export ORACLE_HOME=/usr/lib/oracle/instantclient
  export LD_LIBRARY_PATH=$ORACLE_HOME/
  export TNS_ADMIN=/etc
  export NLS_LANG=AMERICAN_AMERICA.UTF8
fi

#######   VIM   ################################################################
export VISUAL="$(which vim)"
export EDITOR="$VISUAL"
