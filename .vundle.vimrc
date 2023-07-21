"""""VUNDLE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  " add fzf to runtime
  set rtp+=/usr/local/opt/fzf

  call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'


"""""""PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup PLUGINS
  Plugin 'bling/vim-airline'
augroup END
"""""""PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " All of your Plugins must be added before the following line
  call vundle#end()            " required
  filetype plugin indent on    " required
