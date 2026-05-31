# ~/.bash_profile: Bootstraps the shell configuration from ~/.shell/bash/.profile

if [ -f "$HOME/.shell/bash/.profile" ]; then
  source "$HOME/.shell/bash/.profile"
fi
