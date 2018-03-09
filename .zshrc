##########ANTIGEN###############################################################
# @TODO: Determine if we'll lookup source
source /usr/local/share/antigen/antigen.zsh

# OMZ
antigen use oh-my-zsh

# PLUGINS
# Bundles from oh-my-zsh
antigen bundle aws
antigen bundle battery 
antigen bundle composer 
antigen bundle command-not-found
antigen bundle docker 
antigen bundle docker-compose 
antigen bundle heroku
antigen bundle git 
antigen bundle gitfast 
antigen bundle git-extras 
antigen bundle git_remote_branch 
antigen bundle grunt 
antigen bundle history 
antigen bundle jira 
antigen bundle jsontools 
antigen bundle node 
antigen bundle npm 
antigen bundle nvm 
antigen bundle osx 
antigen bundle pip 
antigen bundle redis-cli 
antigen bundle rsync 
antigen bundle safe-paste 
antigen bundle sudo 
antigen bundle symfony2 
antigen bundle urltools 
antigen bundle vagrant 
antigen bundle vi-mode 
antigen bundle vundle
antigen bundle wd 
antigen bundle web-search 
antigen bundle yum 
antigen bundle zsh-autosuggestions

# COMLETIONS
# TODO: https://github.com/github/hub/blob/master/etc/hub.zsh_completion
# Syntax highlighting bundle.
antigen bundle https://github.com/hchbaw/opp.zsh.git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle https://github.com/b4b4r07/zsh-vimode-visual.git

# THEMES
antigen theme crunch
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k

# APPLY CONFIG
antigen apply
##########ANTIGEN###############################################################
