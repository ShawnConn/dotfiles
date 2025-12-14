"""""VIM-PLUG"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  set nocompatible              " be iMproved, required

  " via https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
  " Install vim-plug if not found
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
  \| endif

  " add fzf to runtime
  set rtp+=/usr/local/opt/fzf

  call plug#begin('~/.vim/plugged')

"""""""PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup PLUGINS
  if !has('nvim')
    Plug 'joonty/vdebug'
  endif
  Plug 'bling/vim-airline'
  Plug 'chiel92/vim-autoformat'
  Plug 'chr4/nginx.vim'
  Plug 'chrisbra/nrrwrgn'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'elzr/vim-json'
  Plug 'ernstwi/vim-sticky'
  Plug 'evidens/vim-twig'
  Plug 'girishji/autosuggest.vim'
  Plug 'girishji/vimcomplete'
  "Plug 'github/copilot.vim'
  Plug 'glench/vim-jinja2-syntax'
  Plug 'godlygeek/tabular'
  Plug 'groenewege/vim-less'
  Plug 'hashivim/vim-hashicorp-tools'
  Plug 'https://git.drupal.org/project/vimrc.git', {'rtp': 'bundle/vim-plugin-for-drupal/'}
  Plug 'itchyny/vim-cursorword'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'kkoomen/vim-doge'
  Plug 'leafgarland/typescript-vim'
  Plug 'luciditi/vim-signature'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'madox2/vim-ai'
  Plug 'madox2/vim-ai-provider-google'
  Plug 'majutsushi/tagbar'
  Plug 'mbbill/undotree'
  Plug 'mtth/scratch.vim'
  Plug 'mxw/vim-jsx'
  Plug 'myint/syntastic-extras'
  Plug 'osyo-manga/vim-hopping'
  Plug 'osyo-manga/vim-over'
  Plug 'pangloss/vim-javascript'
  Plug 'pearofducks/ansible-vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/syntastic'
  Plug 'shawnconn/vim-colorschemes'
  Plug 'shawncplus/phpcomplete.vim'
  Plug 'shmup/vim-sql-syntax'
  Plug 'sjl/clam.vim'
  Plug 'stanangeloff/php.vim'
  Plug 'terryma/vim-expand-region'
  Plug 'tmhedberg/matchit'
  Plug 'tomlion/vim-solidity'
  Plug 'townk/vim-autoclose'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'vasconcelloslf/vim-interestingwords'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-php/tagbar-phpctags.vim'
  Plug 'vim-scripts/repmo.vim'
  Plug 'wellle/targets.vim'
  Plug 'wilywampa/vim-easymotion'
  Plug 'yggdroot/indentline'
augroup END
"""""""PLUGINS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  call plug#end()
  filetype plugin indent on
