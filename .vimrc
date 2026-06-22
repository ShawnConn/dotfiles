"""""""LUCIDITI .VIMRC"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""PLUGINS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.plugins.vimrc

"""""""SOURCES"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SOURCES

augroup END

"""""""TEMPLATE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TEMPLATE

augroup END

"""""""DEBUGGING"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup DEBUGGING
  au!

  " Use :call ToggleVerbose() to dump a verbose log
  function! ToggleVerbose()
    if !&verbose
      set verbosefile=~/.vim/verbose.log
      set verbose=15
    else
      set verbose=0
      set verbosefile=
    endif
  endfunction

augroup END

"""""""USEFUL COMMANDS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup USEFUL COMMANDS
  au!
  "  __           :  _____________________________________.
  "  ``           :  Return to previous cursor before jump.
  "  gi           :  Last Place in Insert Mode.

augroup END

"""""""NEOVIM""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup NEOVIM
  au!
  "CONFIGURE FOR NEOVIM
  if has('nvim')
  endif
augroup END

"""""""ABBREVIATIONS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ABBREVIATIONS
augroup END

"""""""AUTOCOMPLETE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup AUTOCOMPLETE
  au!
  "j/k to navigate
  "autocomplete menu
  inoremap <expr> J ((pumvisible())?("\<C-n>"):("J"))
  inoremap <expr> K ((pumvisible())?("\<C-p>"):("K"))

  "Dictionary complete with Tab+d
  inoremap <Tab>d <C-X><C-k>

  "Line complete with Tab+l
  inoremap <Tab>l <C-x><C-l>

  "Autocomplete from dictionary as well
  set complete+=k

  "Personal Dictionary complete with C-d
  silent! set dict +=~/.vim/dictionaries/personal.dict
augroup END

"""""""BAD COMMANDS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup BAD COMMANDS
augroup END

"""""""COMMANDS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup COMMANDS
  au!
  "Set leader to Space
  let mapleader = "\<Space>"
  let g:mapleader = "\<Space>"
  let g:maplocalleader = "\\"

  "Double tap local leader for prev buffer
  noremap <Localleader><Localleader> <c-^>

  "Map g+j/k to move down to the first no blank character
  noremap gj +
  noremap gk -

  "Map g+J/K to move down to the first empty line
  noremap gJ }
  noremap gK {

  "Map jk for escaping insert/visual/comman mode
  inoremap jk <Esc>
  inoremap kj <Esc>
  cnoremap jk <C-c>

  " Move visual block
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  "Yank visual mode w/ return
  vnoremap <CR> y

  "Remap 0 to toggle home position
  nnoremap 0 :call ToggleHomeZero()<CR>

  "Fast saving/quiting
  nmap <Leader>w :w!<CR>
  nmap <Leader>Q :qa!<CR>
  nmap <Leader>q :q<CR>

  "No typos on force quit
  cnoremap Q q

  "Disable EX-cmd
  noremap Q <nop>

  "Adjust EX-mode;;
  nnoremap <Leader>' Q

  "Smart way to move between windows
  nnoremap <silent> <Leader>j <C-W>j
  nnoremap <silent> <Leader>k <C-W>k
  nnoremap <silent> <Leader>h <C-W>h
  nnoremap <silent> <Leader>l <C-W>l

  "When you press <Leader>r you can search and replace the selected text
  vnoremap <leader>r y:<C-u>%s/<C-R>"//gc<left><left><left>

  "Leader+r to do interactive find/replace regex
  nmap <Leader>r :OverCommandLine <CR> %s/

  "Toggle white space display
  nmap <Leader>ss :set list!<CR>
  set lcs=tab:▶\ ,eol:¬,extends:>,precedes:<
  let &showbreak='↪ '

  "Navigate Buffers with Space+(,|.)
  nnoremap <Leader>, :bp<CR>
  nnoremap <Leader>. :bn<CR>
  nnoremap <Leader>b1 :b 1<CR>
  nnoremap <Leader>b2 :b 2<CR>
  nnoremap <Leader>b3 :b 3<CR>
  nnoremap <Leader>b4 :b 4<CR>
  nnoremap <Leader>b5 :b 5<CR>
  nnoremap <Leader>b6 :b 6<CR>
  nnoremap <Leader>b7 :b 7<CR>
  nnoremap <Leader>b8 :b 8<CR>
  nnoremap <Leader>b9 :b 9<CR>
  nnoremap <Leader>b0 :bl<CR>

  "Navigate Tabs with Space+t,(<|>)
  nnoremap <Leader>< :tabp<CR>
  nnoremap <Leader>> :tabn<CR>
  nnoremap <Leader>t1 :tabn 1<CR>
  nnoremap <Leader>t2 :tabn 2<CR>
  nnoremap <Leader>t3 :tabn 3<CR>
  nnoremap <Leader>t4 :tabn 4<CR>
  nnoremap <Leader>t5 :tabn 5<CR>
  nnoremap <Leader>t6 :tabn 6<CR>
  nnoremap <Leader>t7 :tabn 7<CR>
  nnoremap <Leader>t8 :tabn 8<CR>
  nnoremap <Leader>t9 :tabn 9<CR>
  nnoremap <Leader>t0 :tabl<CR>

  " Delete marker
  nnoremap <Leader>d' :delm

  "Buffer quit
  nnoremap <Leader>bq :bp<Bar>sp<Bar>bn<Bar>bd<CR>
  nnoremap <Leader>bc :%bd<CR>

  "Split quit
  nnoremap <Leader>sq <C-w>q

  "Tab quit
  nnoremap <Leader>tq :tabclose<CR>

  "Pressing <Leader>sp will toggle and un-toggle spell checking
  nnoremap <Leader>sp :setlocal spell!<CR>

  "Use paste mode with yo, yO, yi, yI, ya, yA
  nnoremap <Leader>yp :set paste!<CR>
  nnoremap <silent>yo  :set paste<CR>o
  nnoremap <silent>yO  :set paste<CR>O
  nnoremap <silent>yi  :set paste<CR>i
  nnoremap <silent>yI  :set paste<CR>I
  nnoremap <silent>ya  :set paste<CR>a
  nnoremap <silent>yA  :set paste<CR>A

  " P or <Leader>p will keep register contents
  vnoremap P "_dP
  vnoremap <Leader>p "_dP

  "Tab will jump to matched char
  nnoremap <Tab> %
  vnoremap <Tab> %
  map <Tab> %

  "Move <C-h>/<C-l> start/end for insert/commands
  inoremap <C-h> <ESC>I
  inoremap <C-l> <ESC>A
  cnoremap <C-h> <HOME>
  cnoremap <C-l> <END>
  cnoremap <C-j> <S-Left>
  cnoremap <C-k> <S-Right>

  "~ is operator like
  set tildeop

  "map diff next/prev to dn/dN
  nnoremap dn ]c
  nnoremap dN [c

  "Use dy to be consistent with y/p
  nnoremap dy do

  "Skip folds with { & }
  nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
  nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"
  " IGNORE: FIX FOR .vimrc SynHighlight: }

  "ENTER to get a command out
  map <Leader><CR> :

  " Source For Testing VimScript
  vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
  nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR> "

  "write in case didn't sudo
  cnoremap w!! w !sudo tee % >/dev/null

  "Automatically source vimrc on save.
  au! bufwritepost $MYVIMRC source $MYVIMRC

  "Select just pasted text
  noremap gV `[v`]

  "Move text to left/right/center
  nnoremap <Leader>.l :left<CR>
  vnoremap <Leader>.l :left<CR>
  nnoremap <Leader>.c :center<CR>
  vnoremap <Leader>.c :center<CR>
  nnoremap <Leader>.r :right<CR>
  vnoremap <Leader>.r :right<CR>

  "Select indented line
  nnoremap vv ^vg_

  "Visual Block with <Leader>+vb
  noremap <Leader>vb <C-v>

  "Horizontal split w/ C-w,h
  nnoremap <C-w>h :split<CR>
  "Vertical split w/ C-w,v
  nnoremap <C-w>v :vsplit<CR>

  """"" Shell """""
  "Quick var ref
  au FileType bash,sh,zsh inoremap vv $
  """"" Shell """""

  """"" PHP/Drupal """""
  "Quick object ref & array key/val assignment
  au FileType drush,php,module,inc,
        \install,test,profile,theme ino -- ->
  au FileType drush,php,module,inc,
        \install,test,profile,theme ino ;; ::
  au FileType drush,php,module,inc,
        \install,test,profile,theme ino -= =>

  "Quick var ref
  au FileType drush,php,module,inc,
        \install,js,test,profile,theme ino vv $

  "Quick PHP functions
  au FileType drush,php,module,inc,
        \install,test,profile,theme ino vd var_dump

  "Quick end statement
  nnoremap <Leader>; A;<ESC>
  """"" PHP/Drupal """""

  """"" Markdown """""
  " <Leader>+b = Wrap bold (ASCII 98 = b)
  au FileType markdown,text let b:surround_98 = "**\r**"
  au FileType markdown,text vmap <buffer><silent><Leader>b Sb
  " <Leader>+c = Wrap ,textcode
  au FileType markdown,text vmap <buffer><silent><Leader>c S`
  " <Leader>+C = Wrap ,textcode block
  au FileType markdown,text let b:surround_99 = "```\n\r\n```"
  au FileType markdown,text vmap <buffer><silent><Leader>C Sc
  " <Leader>+e = Wrap ,textexample code block
  au FileType markdown,text vmap <buffer><silent><Leader>e Sci<BS><ESC>
  " <Leader>+p = Wrap ,textpicture/image
  au FileType markdown,text vmap
      \ <buffer><silen,textt><Leader>p S]%a(<C-R>+ "TITLE")<ESC><TAB>h<TAB>i!<ESC>
  " <Leader>+i = Wrap ,textitalic
  au FileType markdown,text vmap <buffer><silent><Leader>i S_
  " <Leader>+l = Wrap ,textclipboard link
  au FileType markdown,text vmap <buffer><silent><Leader>l S]%a(<C-R>+)<ESC>
  " <Leader>+s = Wrap ,textstrikethrough (ASCII 115 = s)
  au FileType markdown,text let b:surround_115 = "~~\r~~"
  au FileType markdown,text vmap <buffer><silent><Leader>s Ss
  " <Leader>+q = Block,textquote (Prepends '> ' to selected lines)
  au FileType markdown,text vnoremap <buffer><silent><Leader>q :s/^/> /<CR>:noh<CR>
  " <Leader>+u = Unord,textered List (Prepends '- ' to selected lines)
  au FileType markdown,text vnoremap <buffer><silent><Leader>u :s/^/- /<CR>:noh<CR>
  " <Leader>+o = Order,texted List (Prepends '1. ' to selected lines. Markdown auto-numbers on render!)
  au FileType markdown,text vnoremap <buffer><silent><Leader>o :s/^/1. /<CR>:noh<CR>
  " <Leader>+t = Task ,textList (Prepends '- [ ] ' to selected lines)
  au FileType markdown,text vnoremap <buffer><silent><Leader>t :s/^/- [ ] /<CR>:noh<CR>
  " <Leader>+x = Toggl,texte task checkbox [ ] <-> [x]
  au FileType markdown,text nnoremap <buffer><silent><Leader>x :s/\[\([ x]\)\]/\=submatch(1) == ' ' ? '[x]' : '[ ]'/e<CR>:noh<CR>
  " <Leader>+h = Incre,textase Header level
  au FileType markdown,text nnoremap <buffer><silent><Leader>h :s/^\(#*\)\( \?\)/\1# /<CR>:noh<CR>
  " <Leader>+r = Inser,textt Horizontal Rule below current line
  au FileType markdown,text nnoremap <buffer><silent><Leader>r o<CR>---<CR><CR><ESC>
  " <Leader>+d = Wrap ,textin HTML <details> block (ASCII 100 = d)
  au FileType markdown,text let b:surround_100 = "<details>\n<summary>Details</summary>\n\n\r\n</details>"
  au FileType markdown,text vmap <buffer><silent><Leader>d Sd
  """"" Markdown """""
augroup END

"""""""""FORMATTING""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup FORMATTING
  au!
  "Cursor Position
  set ruler

  "Automatically remove trailing whitespace for certain files
  au BufWritePre *.c,*.cpp,*.css,*.drush,*.inc,*.install,*.html,*.java,*.js,*.module,*.php,*.pl,*.rb,*.sh,*.theme,*.test :%s/\s\+$//e

  "Set status line with file info
  set statusline=\ %{HasPaste()}%F%m%r%h%w
        \\ [FORMAT=%{&ff}]
        \\ [TYPE=%Y]
        \\ [ASCII=\%03.3b]
        \\ [HEX=\%02.2B]
        \\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
  set laststatus=2

  "Change Cursor With Mode
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  "Wildmenu
  set wildmenu
  set wildmode=list:longest,full

  "Ignore Some Items
  set wildignore+=.hg,.git,.svn                    " Version control
  set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
  set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
  set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
  set wildignore+=*.spl                            " compiled spelling list
  set wildignore+=*.sw?                            " Vim swap files
  set wildignore+=*.DS_Store                       " OSX bullshit
  set wildignore+=*.luac                           " Lua byte code
  set wildignore+=migrations                       " Django migrations
  set wildignore+=*.pyc                            " Python byte code
  set wildignore+=*.orig                           " Merge resolution files

  "Set line numbers
  set number
  nmap <F2> :set number! number?<CR>
  set autoindent

  "Toggle relative line numbering
  nmap <Leader><Leader>n :set invrelativenumber!<CR>
  "set invrelativenumber

  "Tab = 2 spaces
  set expandtab
  set ts=2
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set backspace=2
  set smarttab
  set smartindent

  "Bracket formatting for new bloc
  inoremap {<CR> {<CR>}<ESC>O
  " FIX FOR SynHighlight: }

  "Round indentation to soft tab
  set shiftround

  "For regular expressions turn magic on
  set magic

  "Set utf8 as standard encoding and en_US as the standard language
  set encoding=utf8

  "Use Unix as the standard file type
  set ffs=unix,mac,dos

  " Enforce consistent line endings: if 'ff' is set to "unix" and there are
  " any " stray '\r' characters at ends of lines, then automatically remove
  " them. See  $VIMRUNTIME/indent/php.vim .
  let PHP_removeCRwhenUnix = 1

  ":FormatNewline = the Windows ^M - when the encodings gets messed up
  if !exists(":FormatNewline")
    command FormatNewline execute "normal mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm"
  endif

  ":FormatRetab = Retab document
  if !exists(":FormatTab")
    command FormatTab execute "retab <CR>"
  endif
augroup END

"""""""""FUGITIVE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup FUGITIVE
  au!
  function! GBrowseLine()
    exe ':'.line('.').'GBrowse'
  endfunction

  noremap <Leader>gs :Git<CR>
  noremap <Leader>gd :Gdiffsplit<CR>
  noremap <Leader>gda :Git difftool -y<CR>
  noremap <Leader>gc :Git commit<CR>
  noremap <Leader>gb :Git blame<CR>
  noremap <Leader>gh :Gclog<CR>
  noremap <Leader>gl :Git log<CR>
  noremap <Leader>gm :Git mergetool -y<CR>
  noremap <Leader>gp :Git push<CR>
  noremap <Leader>gv :call GBrowseLine()<CR>
augroup END

"""""""""HIGHLIGHTING""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup HIGHLIGHTING
  au!
  "File Type
  filetype plugin on

  "Syntax Highlighting
  syntax on

  "BaseLibs/SQL/HTML Highlighting
  let php_sql_query = 1
  let php_baselib = 1
  let php_htmlInStrings = 1

  "Keep selection highlighted through indentation shifting
  vmap < <gv
  vmap > >gv

  "Change highlight
  nmap <Leader>ch :set cursorcolumn!<CR>:set cursorline!<CR>

  "Highlight redundant whitespaces and tabs.
  highlight RedundantSpaces ctermbg=red guibg=red
  au WinEnter,VimEnter * match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

  "Incremental search/nopaste/comment block
  set comments=sr:/*,mb:*,ex:*/

  "HCL highlighting
  autocmd BufRead,BufNewFile *.hcl set filetype=terraform

  "HTML/PHP/JS/CSS autocomplete
  au FileType css set omnifunc=csscomplete#CompleteCSS
  au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  au FileType js set omnifunc=javascriptcomplete#CompleteJS
  au FileType javascript
        \ setlocal omnifunc=javascriptcomplete#CompleteJS
  au FileType php setlocal omnifunc=phpcomplete#CompletePHP
  au FileType module setlocal omnifunc=phpcomplete#CompletePHP
  au FileType drush setlocal omnifunc=phpcomplete#CompletePHP
  au FileType theme setlocal omnifunc=phpcomplete#CompletePHP
  au FileType python setlocal omnifunc=pythoncomplete#Complete
  au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  "Drupal *.module and *.install files.
  au BufRead,BufNewFile *.module set filetype=php
  au BufRead,BufNewFile *.drush set filetype=php
  au BufRead,BufNewFile *.install set filetype=php
  au BufRead,BufNewFile *.theme set filetype=php
  au BufRead,BufNewFile *.test set filetype=php
  au BufRead,BufNewFile *.inc set filetype=php
  au BufRead,BufNewFile *.view set filetype=php

  "Highlight log messages
  au BufNewFile,BufReadPost *.log :set filetype=messages
  au BufNewFile,BufReadPost /var/log/* :set filetype=messages

  "Markdown Highlighting
  au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md
        \,README.txt
        \ :set filetype=markdown
  let g:markdown_fenced_languages = [
        \ 'css', 'erb=eruby', 'javascript', 'js=javascript',
        \ 'json=javascript', 'ruby', 'sass', 'xml', 'html', 'typescript',
        \ 'ts=typescript', 'dart', 'go', 'python', 'rust', 'bash=sh', 'sh',
        \ 'zsh', 'php', 'vim', 'terraform', 'yaml'
        \ ]

  "Supresss errors
  au CursorMovedI * if pumvisible() == 0|pclose|endif
  au InsertLeave * if pumvisible() == 0|pclose|endif

  "Function Folding (Disable Autocomplete Performance)
  set nofoldenable

  "Folding for certain languages
  set foldmethod=indent
  set foldnestmax=2
  let javaScript_fold=1         " JavaScript
  let perl_fold=1               " Perl
  let php_folding = 0           " PHP
  let r_syntax_folding=1        " R
  let ruby_fold=1               " Ruby
  let vimsyn_folding='af'       " Vimscript
  let xml_syntax_folding=1      " XML

  "Use folding for .vimrc
  au BufNewFile,BufRead *.vimrc set foldenable

  "Use folding for .sh
  au BufNewFile,BufRead *.sh set foldmethod=marker
  au BufNewFile,BufRead *.sh set foldmarker={{{,}}}
  au BufNewFile,BufRead *.sh set foldenable

  "This fold is the one true king
  nnoremap <Leader>zc zMzvzz

  "Turn off folding
  nnoremap <Leader>zz :set nofoldenable!<CR>

  "Set PHP function folding
  nnoremap <Leader>zp :EnablePHPFolds<CR>zM
  nnoremap <Leader>zf :EnableFastPHPFolds<CR>zM

augroup END

""""""""""BINARY"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup BINARY
  au!
  "Editing .bin files
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

"""""""""MAC VIM"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MAC VIM
  au!
  "Set Nerd Fonts
  if has("gui_running")
    set guioptions=egmrt
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h10
  else
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 10
  endif
  "Set clipboard register
  set clipboard+=unnamed

  "Resize splits
  au VimResized * exe "normal! \<C-w>="
augroup END

"""""""""POSITION""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup POSITION
  au!
  "When editing a file, always jump to the last cursor position
  au BufReadPost *
        \ if ! exists("g:leave_my_cursor_position_alone") |
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \ exe "normal g'\"" |
        \ endif |
        \ endif

  "Remember info about open buffers on close & 10 marks
  set viminfo^=%,'10,/10,:10

  "Jump 15 line at a time and scroll two lines before the end
  if !has('nvim')
    set scrolljump=20
  endif
  set scrolloff=5

  " Keep search matches in the middle of the window.
  nnoremap n nzz
  nnoremap N Nzz

  " Same when jumping around
  nnoremap g; g;zz
  nnoremap g, g,zz
  nnoremap <C-o> <C-o>zz

  " Use H/L to get to BOL/EOL
  noremap H ^
  noremap L $
  vnoremap L g_

  " Use <Leader> H/L to jump top/bottom
  noremap <Leader>H H
  noremap <Leader>L L

  "Add <> as matching pairs
  set matchpairs+=<:>
augroup END

"""""""""QUICK EDITS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup QUICK EDITS
  au!
  nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
  nnoremap <Leader>eb :vsplit ~/.bash_profile<CR>
  nnoremap <Leader>eg :vsplit ~/.gitconfig<CR>
  nnoremap <Leader>eh :vsplit /etc/hosts<CR>
  nnoremap <Leader>es :vsplit ~/.ssh/config<CR>
  nnoremap <Leader>ez :vsplit ~/.zshrc<CR>
  nnoremap <Leader>ep :vsplit ~/.plugins.vimrc<CR>
  nnoremap <Leader>ec :vsplit ~/.vim/coc-settings.json<CR>
  nnoremap <Leader>eai :AIUtilRolesOpen<CR>
augroup END

"""""""""SEARCH""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SEARCH
  au!
  "Ignore certain files
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

  "Highlight Search
  set hlsearch

  "Ignore case when searching
  set ignorecase

  "When searching try to be smart about cases
  set smartcase

  "Show included search
  set incsearch

  "Remove vim escaped regex chars
  nnoremap / /\v\c
  vnoremap / /\v\c

  " Visual mode pressing * or # searches for the current selection
  vnoremap <silent> * y:/<C-R>"<CR>
  vnoremap <silent> # y:?<C-R>"<CR>

  "Leader+ESC will toggle off search highlighting
  nnoremap <Leader><ESC> :nohlsearch<CR>

  "Search from highlight mode
  vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><C-o>
  vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><C-o>

  "Search directory for instances of the current word
  noremap <Leader>#
        \ :execute "grep -r '" . expand("<cword>") . "' . " <Bar> cw<CR><CR>

  "Use Silver Searcher instead of grep
  if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
  endif

augroup END

"""""""""SETTINGS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SETTINGS
  au!

  "Set Backup Dir
  set backupdir =~/.vim/backup//
  " Some servers have issues with backup files (e.g. coc.nvim), so keep backups off
  set nobackup
  set nowritebackup

  "Set Swap Dir
  set directory =~/.vim/swap//
  set noswapfile

  "Set Undo Dir
  silent! set undodir =~/.vim/undo//

  "Set Autoread
  set ar

  "Split below/right
  set splitbelow
  set splitright

  "Setting timeout length
  set ttimeout
  set ttimeoutlen=100

  "Show matching brackets when text indicator is over them
  set showmatch
  "How many tenths of a second to blink when matching brackets
  set mat=2

  "Show leader command active
  set showcmd

  "History length
  set history=5000

  "Keep buffer in memory after close.
  set hidden
augroup END

"""""""""TABULARIZE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TABULARIZE
  au!
  " https://devhints.io/tabular
  noremap <Leader>t= :Tabularize /=
  noremap <Leader>t: :Tabularize /:
  noremap <Leader>t:: :Tabularize /:\zs
  noremap <Leader>t, :Tabularize /,
  noremap <Leader>t<Bar> :Tabularize /
augroup END

"""""""""TEMPLATES"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TEMPLATES
  au!

  "For new files load a template
  au BufNewFile *.html 0r ~/.vim/templates/_.html

  au BufNewFile *.php 0r ~/.vim/templates/_.php
  au BufNewFile *.php :normal G

  au BufNewFile *.sh 0r ~/.vim/templates/_.sh
  au BufNewFile *.sh :normal G

  au BufNewFile *.bash 0r ~/.vim/templates/_.sh
  au BufNewFile *.bash :normal G

augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""PLUGIN CONFIGURATIONS"""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""AIRLINE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup AIRLINE
  au!
  "Prettify
  let g:airline_powerline_fonts = 1
  let g:airline_theme='dark'

  "Tabline display
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#tab_nr_type= 1
  let g:airline#extensions#tabline#tabs_label = '↹'
  let g:airline#extensions#tabline#buffers_label = '▤'
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#fnametruncate = 15

  "Branches
  let g:airline#extensions#branch#displayed_head_limit = 15
  let g:airline#extensions#branch#sha1_len = 7
  let g:airline#extensions#branch#format = 2

  "Buffer lines
  let g:airline#extensions#tabline#show_buffers = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s:'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'

  "Custom whitespace checking
  let g:airline#extensions#whitespace#checks =
        \ ['indent', 'trailing']
  let g:airline#extensions#whitespace#trailing_format = 'trail[%s]'
  let g:airline#extensions#whitespace#mixed_indent_format = 'm-indent[%s]'
  let g:airline#extensions#whitespace#long_format = 'long[%s]'

  let g:airline#extensions#gutentags#enabled = 1

  "Syntastic (disabled)
  let g:airline#extensions#syntastic#enabled = 0

  "Add Buffer Index
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9

  "Short buffer stats +HEX
  let g:airline_section_z = '%3p%% %l:%c|0x%B'
augroup END



"""""""""CLAM""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup CLAM
  au!
  "Bang your way to shell
  nnoremap ! :Clam<space>
  vnoremap ! :ClamVisual<space>
augroup END

"""""""""COC"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup COC
  au!
  " Ex: https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim

  " May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
  " utf-8 byte sequence
  set encoding=utf-8


  " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
  " delays and poor user experience
  set updatetime=100

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use <c-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-space> coc#refresh()
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
  nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
  nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent><nowait> gd <Plug>(coc-definition)
  nmap <silent><nowait> gy <Plug>(coc-type-definition)
  nmap <silent><nowait> gi <Plug>(coc-implementation)
  nmap <silent><nowait> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call ShowDocumentation()<CR>

  " Highlight the symbol and its references when holding the cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code
  "xmap <leader>f  <Plug>(coc-format-selected)
  "nmap <leader>f  <Plug>(coc-format-selected)

  " Applying code actions to the selected code block
  " Example: `<leader>aap` for current paragraph
  " Example: `<leader>aw` for current word
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying code actions at the cursor position
  nmap <leader>ac  <Plug>(coc-codeaction-cursor)
  " Remap keys for apply code actions affect whole buffer
  nmap <leader>as  <Plug>(coc-codeaction-source)
  " Apply the most preferred quickfix action to fix diagnostic on the current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Remap keys for applying refactor code actions
  nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
  "xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
  "nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

  " Run the Code Lens action on the current line
  nmap <leader>cl  <Plug>(coc-codelens-action)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use CTRL-S for selections ranges
  " Requires 'textDocument/selectionRange' support of language server
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer
  command! -nargs=0 Format :call CocActionAsync('format')

  " Add `:Fold` command to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer
  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

  " Get Extensions
  " https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
     "\ 'coc-copilot',
     "\ 'coc-fzf-preview',
     "\ 'coc-prettier',
  let g:coc_global_extensions = [
     \ '@yaegassy/coc-ansible',
     \ 'coc-css',
     \ 'coc-docker',
     \ 'coc-explorer',
     \ 'coc-git',
     \ 'coc-go',
     \ 'coc-html',
     \ 'coc-json',
     \ 'coc-lightbulb',
     \ 'coc-markdown-preview-enhanced',
     \ '@yaegassy/coc-nginx',
     \ 'coc-phpactor',
     \ 'coc-pydocstring',
     \ 'coc-pyright',
     \ 'coc-rome',
     \ 'coc-rls',
     \ 'coc-sh',
     \ 'coc-solargraph',
     \ 'coc-spell-checker',
     \ 'coc-sql',
     \ 'coc-toml',
     \ 'coc-tsserver',
     \ 'coc-vimlsp',
     \ 'coc-yank',
     \ 'coc-webview',
     \ 'coc-xml',
     \ 'coc-yaml',
     \ ]

  " Generate Markdown Preview
  nmap <Leader>mdp :CocCommand markdown-preview-enhanced.openPreview<CR>
augroup END

"""""""DOGE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup DOGE
  au!
  let g:doge_php_settings = {
        \  'resolve_fqn': 1
        \}
  let g:doge_python_settings = {
        \  'single_quotes': 0
        \}
augroup END

"""""""EASYMOTION""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup EASYMOTION
  au!
  " search with <Leader>+f
  nnoremap <Leader>f <Plug>(easymotion-overwin-f)
  nnoremap <Leader><Leader>f <Plug>(easymotion-overwin-f2)
  vnoremap <Leader><Leader>f <Plug>(easymotion-overwin-f2)

  "nmap <Leader>W <Plug>(easymotion-overwin-w)

  " replace native vim s (use cl instead)
  nnoremap s <Plug>(easymotion-s)
  vnoremap s <Plug>(easymotion-s)

  "Add easymotion search
  map <Leader>m <Plug>(easymotion-sn)
  map <Leader>n <Plug>(easymotion-next)
  map <Leader>N <Plug>(easymotion-prev)

  "Add 2x leader easymotion directions
  map <Leader><Leader>l <Plug>(easymotion-lineforward)
  map <Leader><Leader>j <Plug>(easymotion-bd-jk)
  map <Leader><Leader>h <Plug>(easymotion-linebackward)
  map <Leader><Leader>w <Plug>(easymotion-bd-w)

  "Repeat last motion
  map <Leader><Leader>s <Plug>(easymotion-repeat)

  "keep cursor column when JK motion
  let g:EasyMotion_startofline = 0
  " Use uppercase target labels and type as a lower case
  "let g:EasyMotion_use_upper = 1
  " type `l` and match `l`&`L`
  let g:EasyMotion_smartcase = 1
  " Smartsign (type `3` and match `3`&`#`)
  let g:EasyMotion_use_smartsign_us = 1
augroup END

"""""""EDITORCONFIG""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup EDITORCONFIG
  au!
  let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

augroup END

"""""""FZF"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup FZF
  au!
  "Set filename search
  nnoremap <Leader>o :Files<CR>

  "Set filebody search
  nnoremap <Leader>/ :F<CR>
  let g:rg_command = '
        \ rg --column --line-number --no-heading --fixed-strings --ignore-case
        \ --no-ignore --hidden --follow --color "always"
        \ -g "!{.git,node_modules,vendor}/*" '
  command! -bang -nargs=* F
        \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
  let g:fzf_layout = { 'down': '~40%' }
  let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
augroup END

"""""""GUTENTAGS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup GUTENTAGS
  au!
  "Specify cache dir in vim folder
  let g:gutentags_cache_dir = '~/.vim/gutentags'

  "let g:gutentags_exclude = ['*.css', '*.html', '*.js']

  " prevent gutentags from indexing the entire home directory
  " https://github.com/ludovicchabant/vim-gutentags/issues/13
  let s:notags = expand('~/.notags')
  if !filereadable(s:notags)
    call writefile([], s:notags)
  endif

augroup END

"""""""HOPPING.VIM"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup HOPPING.VIM
  au!
  " Map to Leader+/
  nmap <Space>? <Plug>(hopping-start)

  " Keymapping
  let g:hopping#keymapping = {
        \ "\<C-n>" : "<Over>(hopping-next)",
        \ "\<C-p>" : "<Over>(hopping-prev)",
        \ "\<C-u>" : "<Over>(scroll-u)",
        \ "\<C-d>" : "<Over>(scroll-d)",
        \}

augroup END

"""""""INTERSTINGWORDS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup INTERSTINGWORDS
  au!
  nnoremap <silent> <Leader>i :call InterestingWords('n')<CR>
  nnoremap <silent> <Leader>I :call UncolorAllWords()<CR>

  let g:interestingWordsGUIColors = [
        \'134', '101', '211', '137', '214', '222']
augroup END


"""""""LOGVIEWER""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup LOGVIEWER
  au!
  let g:LogViewer_Filetypes = 'log4j,syslog,log'
augroup END



"""""""NERDTREE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup NERDTREE
  au!
  "Give a shortcut key to NERD Tree map
  nmap <Leader>O :NERDTreeToggle<CR>

  "NERDTree open if no files / close if left / open on F4
  "au StdinReadPre * let s:std_in=1
  "au VimEnter *
        "\ if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  "au bufenter * if (winnr("$") == 1
  "\&& exists("b:NERDTreeType")
  "\&& b:NERDTreeType == "primary") | q | endif

  "Set NERDTree Options
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=[
        \'\\.pyc', '\\\~$', '\\.swo$', '\\.swp$',
        \'\\.git', '\\.hg', '\\.svn', '\\.bzr']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=1
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
augroup END

"""""""NRRWRGN"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup NRRWRGN
  au!
  nmap <Leader>nw :NR<CR>
  vmap <Leader>nw :NR<CR>
  let g:nrrw_topbot_leftright = 'botright'

augroup END

"""""""PHPComplete"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup PHPComplete
  au!
  let g:phpcomplete_parse_docblock_comments = 1

  "let g:phpcomplete_mappings = {
        "\ 'jump_to_def': '<C-]>',
        "\ 'jump_to_def_split': '<C-W><C-]>',
        "\ 'jump_to_def_vsplit': '<C-W><C-\>',
        "\ 'jump_to_def_tabnew': '<C-W><C-[>',
  "\}

  "Jump definition binding split
  nmap <Leader>jd <C-W><C-\>

augroup END

"""""""SCRATCH"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SCRATCH
  au!
  let g:scratch_filetype = 'markdown'

augroup END

"""""""SIGNATURE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SIGNATURE
  au!
  nmap <Leader>sm :SignatureToggle<CR>
  nmap <Leader>sr :SignatureRefresh<CR>
augroup END



"""""""TAGBAR""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TAGBAR
  au!
  nmap <Leader>tt :TagbarToggle<CR>

  "TagBar-PHPCTags Options
  let g:tagbar_phpctags_memory_limit = '2G'
  "Compact tags
  let g:tagbar_compact = 1
augroup END

"""""""UNDOTREE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup UNDOTREE
  au!
  "Leader+u Sets Undotree
  nnoremap <Leader>U :UndotreeToggle<CR>
augroup END

"""""""VIM-AI""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VIM-AI
  au!
  let g:vim_ai_roles_config_file = $HOME.'/.config/.vim-ai-roles.ini'

  " run explain on the current visual selection
  xn <leader>\ :AIC Explain this code<CR>

  " open with starting prompt
  nnoremap <leader><leader>\ :AIC
  xn <leader><leader>\ :AIC

  " open AI chat
  nnoremap <leader><CR> :AIC<CR>

  " complete text on the current line or in visual selection
  xn <leader><CR> :AI<CR>

  " open AI prompt for gen code
  nnoremap <leader><leader><CR> :AI
  xn <leader><leader><CR> :AI

  " run AI edit or redo edit
  xn <leader>' :AIE
  nnoremap <leader><leader>' :AIR<CR>

  " Not implemented yet
  "nn <leader>??? :AII
  "xn <leader>??? :AII
  "nn <leader>??? :AIStopChat<CR>
  "nn <leader>??? :AIUtilDebugOn<CR>
  "nn <leader>??? :AIUtilDebugOff<CR>
  "VSCODE
augroup END

"""""""VIM-AUTOFORMAT""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VIM-AUTOFORMAT
  au!
  "let g:formatterpath = ['/some/path/to/a/folder']
  "let g:autoformat_verbosemode=1

  let g:formatters_sh = ['shellharden', 'shfmt']
  "let g:formatdef_shfmt = '"shfmt -i ".(&expandtab ? shiftwidth() : "0")'
  let g:formatdef_shfmt = '"shfmt -i 4"'
  let g:formatdef_shellharden =
        \ '"cat ". expand("%:p") . " | shellharden --transform '''' "'
  let g:run_all_formatters_sh = 1

  nnoremap <Leader>F :Autoformat<CR>
augroup END

"""""""VIM-STICKY""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VIM-STICKY
  au!
  let g:sticky_all = ['cursorcolumn', 'cursorline', 'list']

augroup END

"""""""VIM-SURROUND""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VIM-SURROUND
  au!
  let b:surround_{char2nr('c')} = "```\r```"

augroup END

"""""""VIM-TERRAFORM"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VIM-TERRAFORM
  au!
  " FMT / Align TF files automatically
  let g:terraform_align=1
  let g:terraform_fmt_on_save=1
  let g:terraform_fold_sections=1
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""HELPER FUNCTIONS""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup HELPER
  au!

"""""""""DISPLAY INFO ON COMMAND LINE""""""""""""""""""""""""""""""""""""""""""
  function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
  endfunction

"""""""""RETURNS TRUE IF PASTE MODE IS ENABLED"""""""""""""""""""""""""""""""""
  function! HasPaste()
    if &paste
      return 'PASTE MODE  '
    en
    return ''
  endfunction

"""""""""DISABLES PASTE MODE WHEN LEAVING INSERT MODE""""""""""""""""""""""""""
  au InsertLeave *
        \ if &paste == 1 |
        \     set nopaste |
        \ endif

"""""""""COPY THE CURRENT TEXT SELECTION TO THE SYSTEM CLIPBOARD"""""""""""""""
  if has('gui_running')
    noremap <Leader>y "+y
  else
    " copy to attached terminal using the yank(1) script:
    " https://github.com/sunaku/home/blob/master/bin/yank
    noremap <silent> <Leader>y y
          \ :silent execute
          \   '!/bin/echo -n' shellescape(escape(@0, '\'), 1) '<Bar> yank'
          \ <Bar>redraw!<Return>
  endif



"""""""""TOGGLE THE HOME POSITION""""""""""""""""""""""""""""""""""""""""""""""
  "Credits to https://ddrscott.github.io/blog/2016/vim-toggle-movement/
  function! ToggleHomeZero()
    let pos = getpos('.')
    execute "normal! ^"
    if pos == getpos('.')
      execute "normal! 0"
    endif
  endfunction

"""""""VISUAL SEARCH"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
  endfunction

augroup END

"""""""COLORS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup COLORS
  au!
  "Sample colors @ http://bytefluent.com/vivify/
  set background=dark
  colo valloric

  "Line Colors
  highlight LineNr ctermbg=236
  highlight LineNr ctermfg=222
  highlight LineNr gui=NONE guifg=DarkGrey guibg=NONE

  "Cursor Highlight Colors
  hi CursorLine  cterm=NONE ctermbg=234 ctermfg=35
  hi CursorColumn  cterm=NONE ctermbg=234 ctermfg=35
  hi Visual cterm=NONE ctermbg=67 ctermfg=0

  " Mark 80 char boundary
  set colorcolumn=81

  "Set indent guides
  let g:indent_guides_auto_colors = 0
  if 'dark' == &background
    au VimEnter,Colorscheme *
          \ :hi IndentGuidesOdd  guibg=gray ctermbg=0
    au VimEnter,Colorscheme *
          \ :hi IndentGuidesEven guibg=green ctermbg=234
  else
    au VimEnter,Colorscheme *
          \ :hi IndentGuidesOdd  guibg=gray ctermbg=0
    au VimEnter,Colorscheme *
          \ :hi IndentGuidesEven guibg=green ctermbg=0
  endif

  "Clearer highlighting for diffs
  highlight DiffAdd
        \ cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=bg guibg=Red
  highlight DiffDelete
        \ cterm=bold ctermfg=10 ctermbg=196 gui=none guifg=bg guibg=Red
  highlight DiffChange
        \ cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText
        \ cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

  "autocomplete menu colors
  highlight Pmenu ctermfg=Black ctermbg=White
augroup END

"""""""COC"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup colorscheme_coc_setup | au!
  au!

  func! s:coc_color_setup() abort
    hi! CocFloating ctermbg=black ctermfg=white
    hi! CocFloatActive ctermbg=black ctermfg=white
    hi! CocSearch ctermbg=black ctermfg=white
    hi! CocErrorFloat ctermfg=black ctermfg=white
    hi! CocMenuSel ctermbg=DarkMagenta
  endfunc

  au VimEnter * call s:coc_color_setup()

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
augroup END
