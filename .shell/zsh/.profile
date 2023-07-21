#!/usr/bin/env zsh

# SET ZSH & config P10K as default
# echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>! ~/.zshrc
# cp .default.p10k.zsh ~/.p10k.zsh
# sudo chsh -s $(which zsh) $(whoami)
#######   BREW #################################################################
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

CPU=$(sysctl -n machdep.cpu.brand_string 2>&1 || true)
if [[ $CPU =~ "M1" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

#######   ANTIGEN  #############################################################
if [[ -f "$HOME/.shell/zsh/.profile.antigen" ]]; then
  source "$HOME/.shell/zsh/.profile.antigen"
fi

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

########   SOURCES / VARS  #####################################################
PATH=$PATH:$HOME/bin:$HOME/.shell/bin

#
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

#ZSH-AUTOSUGGESTIONS: Set highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

#ZSH-AUTOSUGGESTIONS: Ctrl+\ to remove auto complete suggestion
# Requires iterm2 ^⌫  to be mapped to ESC sequence: "[[CD"
bindkey '^[[[CD' autosuggest-clear

#ZSH-AUTOSUGGESTIONS: Ctrl+Enter to auto complete history command & execute
# Requires iterm2 ^⏎  to be mapped to ESC sequence: "[[CE"
bindkey '^[[[CE' autosuggest-execute

# Check bin existence
function exists { which $1 &> /dev/null }

#ZSH-AUTOSUGGESTIONS: Ctrl+Space to auto complete history command | (or Ctrl+R if empty)
function _zle-autosuggest-accept {
  if [ -z "$BUFFER" ]; then
    percol_select_history
  else
    zle autosuggest-accept
  fi
}
zle -N _zle-autosuggest-accept
bindkey '^ ' autosuggest-accept

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
bindkey -M vivis 'L' vi-visual-eol

# 'i' will switch back to insert mode
bindkey -M vivis 'i' vi-visual-exit-to-insert

# Fix shift-tab bug: See https://github.com/robbyrussell/oh-my-zsh/pull/3761
bindkey '^[[Z' reverse-menu-complete

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

# Filters for history
#export HISTORY_FILTER_EXCLUDE=("" "")
HISTFILE="$HOME/.zsh_history"
# Expand history length
HISTSIZE=200000
SAVEHIST=200000

# More prominent EOL
PROMPT_EOL_MARK=""

autoload colors && colors

#######   APP CONFIG   #########################################################

#######   DIRENV   #############################################################
if [[ -x "$(command -v direnv)" ]]; then
  eval "$(direnv hook zsh)"
fi

#######   FZF   ################################################################
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

#######   VIM   ################################################################
export VISUAL="$(which vim)"
export EDITOR="$VISUAL"
