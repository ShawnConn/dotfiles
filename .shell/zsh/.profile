#!/usr/bin/env zsh

# SET ZSH & config P10K as default
# echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>! ~/.zshrc
# cp .default.p10k.zsh ~/.p10k.zsh
# sudo chsh -s $(which zsh) $(whoami)

#######   BREW #################################################################
if [[ ! -x "$(command -v brew)" && -d "/home/linuxbrew/" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

#######   M1   #################################################################
CPU=$(sysctl -n machdep.cpu.brand_string 2>&1 || true)
if [[ $CPU =~ "M1" && -x /opt/homebrew/bin/brew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

#######   ANTIGEN  #############################################################
if [[ -f "$HOME/.shell/zsh/.profile.antigen" ]]; then
  source "$HOME/.shell/zsh/.profile.antigen"
fi

#######   OMZ   ################################################################

#Hide host on local machine
DEFAULT_USER=me

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Smart URLs (escape control chars)
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

#
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

##########PLUGINS CONFIGURATION#################################################
#SUDO: !! to sudo command
bindkey -M vicmd '!!' sudo-command-line

#ZSH-AUTOSUGGESTIONS: Set highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

#ZSH-AUTOSUGGESTIONS: Ctrl+x to remove auto complete suggestion
bindkey '^x' autosuggest-clear

#ZSH-AUTOSUGGESTIONS: Ctrl+/ to auto complete history command & execute
bindkey '^_' autosuggest-execute

# Check bin existence
function exists { which $1 &> /dev/null }

#ZSH-AUTOSUGGESTIONS: Ctrl+Space to auto complete history command | (or Ctrl+R if empty)
function _zle-autosuggest-accept {
  if [ -z "$BUFFER" ]; then
    fzf-history-widget
  else
    zle autosuggest-accept
  fi
}
zle -N _zle-autosuggest-accept
bindkey '^ ' _zle-autosuggest-accept

# Pet snippet select w/ Alt-Shift-P
function pet-select() {
  BUFFER=$(pet --config "$HOME/.config/pet/config.toml" search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
bindkey '^[P' pet-select

#HELP: K to load man page for command
bindkey -M vicmd 'K' run-help

#VI MODE: Ctrl+Space to auto complete history command
#10 ms key sequence for VI mode
KEYTIMEOUT=1

# Use B in cmd mode for editing buffer in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'B' edit-command-line

#Set custom cursor for vi mode
function zle-keymap-select zle-line-init {
  # change cursor shape in iTerm2
  case $KEYMAP in
    vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
    viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
  esac

  zle reset-prompt
  zle -R
}
function zle-line-finish {
  print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

#Fix search results to reverse cron
history-beginning-search-backward-then-append() {
  zle history-beginning-search-backward
  zle vi-add-eol
}
zle -N history-beginning-search-backward-then-append

# Bind L in normal/visual mode to EOL
bindkey -M vicmd 'L' end-of-line
if [[ ${keymaps[(ie)vivis]} -le ${#keymaps} ]]; then
  bindkey -M vivis 'L' vi-visual-eol
fi

# 'i' will switch back to insert mode
if [[ ${keymaps[(ie)vivis]} -le ${#keymaps} ]]; then
  bindkey -M vivis 'i' vi-visual-exit-to-insert
fi

# Fix shift-tab bug: See https://github.com/marlonrichert/zsh-autocomplete/issues/418
#bindkey '^[[Z' reverse-menu-complete
if typeset -f add-zsh-hook > /dev/null; then
  add-zsh-hook precmd bind-tab
  bind-tab() {
    bindkey '\t' menu-complete
    bindkey $terminfo[kcbt] reverse-menu-complete
  }
fi

bindkey -M vicmd '^ ' zce

# backspacing
bindkey -v '^?' backward-delete-char

# ctrl+w delete in insert mode
my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

#######   ALIASES   ############################################################
source "$HOME/.shell/zsh/alias"

#######   FUNCTIONS   ##########################################################
for FUNCTIONS in "$HOME"/.shell/zsh/functions/*; do
  [ -e "$FUNCTIONS" ] || continue
  source "$FUNCTIONS"
done

#######   COMPLETIONS   ########################################################
for SCRIPT in "$HOME"/.shell/zsh/completions/*; do
  [ -e "$SCRIPT" ] || continue
  source "$SCRIPT"
done

autoload bashcompinit || true
bashcompinit || true

for SCRIPT in "$HOME"/.shell/bash/completions/*; do
  [ -e "$SCRIPT" ] || continue
  source "$SCRIPT"
done

# Add custom ZSH completions
fpath=("$HOME/.zsh/completions" $fpath)
# cache only once a day
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

if [[ -x "$(command -v cb)" ]]; then
  fpath=("$(brew --prefix clipboard)/share/zsh/site-functions/" $fpath)
fi

########   SOURCES / VARS  #####################################################
PATH=$PATH:$HOME/bin:$HOME/.shell/bin

# Configure Go Paths
export GOROOT=$(brew --prefix go 2> /dev/null)
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


#######   ZSH   ################################################################
# Filters for history
#export HISTORY_FILTER_EXCLUDE=("" "")
HISTFILE="$HOME/.zsh_history"
# Expand history length
HISTSIZE=200000
SAVEHIST=200000

# More prominent EOL
PROMPT_EOL_MARK=""

# Set colors for antigen plugins
autoload colors && colors

#######   APP CONFIG   #########################################################

#######   ALMOSONTOP   #########################################################
ALMOSONTOP=false

#######   ATUIN   ##############################################################

if [[ -x "$(command -v atuin)" ]]; then
  # init w/disable up arrow mode
  eval "$(atuin init zsh --disable-up-arrow  --disable-ctrl-r)"

  # only use local history for inline suggestions
  ZSH_AUTOSUGGEST_STRATEGY="history"

  # bind to Ctrl+u
  bindkey '^u' atuin-search

  # bind to the up key, which depends on terminal mode
  #bindkey '^[[A' atuin-up-search
  #bindkey '^[OA' atuin-up-search
fi

#######   AUTONOTIFY   #########################################################
# Add docker to list of ignored commands (also: disable_auto_notify /enable_auto_notify)
AUTO_NOTIFY_IGNORE+=("bat"  "docker" "g" "vi")

#######   CHEAT   ##############################################################
export CHEAT_EDITOR="vim"
export CHEATCOLORS=true

#######   DIRENV   #############################################################
if [[ -x "$(command -v direnv)" ]]; then
  eval "$(direnv hook zsh)"
fi

#######   FZF   ################################################################
if [[ -x "$(command -v fzf)" ]]; then
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
  source <(fzf --zsh)
fi

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
