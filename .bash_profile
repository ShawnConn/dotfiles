
source "$HOME/.shell/bash/.profile"

#######   BREW #################################################################
if [[ ! -x "$(command -v brew)" && -d "/home/linuxbrew/" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

#######   ALIASES   ############################################################
source "$HOME/.shell/bash/alias"

#######   FUNCTIONS   ##########################################################
source "$HOME/.shell/bash/functions/cpv"
source "$HOME/.shell/bash/functions/docker"
source "$HOME/.shell/bash/functions/iterm2"
source "$HOME/.shell/bash/functions/iterm2-shell-integration"
source "$HOME/.shell/bash/functions/macos"
source "$HOME/.shell/bash/functions/misc"

#######   COMPLETIONS   ########################################################
autoload bashcompinit
bashcompinit
for SCRIPT in "$HOME"/.shell/bash/completions/*; do source "$SCRIPT"; done

#######   SOURCES   ############################################################

# Set custom bin paths
PATH=$PATH:$HOME/.bin

# Configure Go Paths
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Add Custom Config
if [ -f "$HOME/.luciditi/config" ]; then
  source "$HOME/.luciditi/config"
fi

# Export / File Mask
export PATH
umask 007
#######   BASH   ###############################################################
# Get the aliases and functions
if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

#Set File Colors
export CLICOLOR=1

#######   APP CONFIG   #########################################################


#######   CHEAT   ##############################################################
export CHEAT_EDITOR="vim"
export CHEATCOLORS=true

#######   DIRENV   #############################################################
eval "$(direnv hook bash)"

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
