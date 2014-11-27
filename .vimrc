" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" Packet manager Pathogen
execute pathogen#infect()

" Fix pasting:
inoremap <silent> <C-b> <ESC>u:set paste<CR>.:set nopaste<CR>gi

" Reread me after editing
autocmd BufWritePost ~/.vimrc source ~/.vimrc

" Settings #################################################################
" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1
" Settings depending on GUI
if ! has('gui_running')
    " Set palette to term
    let g:solarized_termcolors=256
else
    " Enable line numbers. Issues copying to term
    set number
    " Enable ballon notification on Syntastic
    let g:syntastic_enable_balloons = 1
    " Use the OS clipboard by default (on versions compiled with `+clipboard`)
    " TODO: Copypaste supppor on keybind for GUI ENV
    set clipboard=unnamed "unnamedpls
endif
" Hidden buffers
set hidden
" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=" "
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" set nomodeline
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable syntax highlighting
syntax on
" Highlight current line
" set cursorline
" Make tabs as wide as 4 spaces
set tabstop=4
" Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
"if exists("&relativenumber")
" set relativenumber
" au BufReadPost * set relativenumber
"endif

" Start scrolling 5 lines before the horizontal window border
set scrolloff=5

set nowrap        " don't wrap lines
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
"set visualbell           " don't beep
set noerrorbells         " don't beep
set autowrite           " Write the contents of the file, if it has been modified, on each :next, etc
set expandtab           " insert space characters whenever the tab key is pressed
set shiftwidth=4        " number of space characters inserted for indentation
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
" A file that matches with one of these patterns is ignored when completing file or directory names
set wildignore=*.o,*.pdf,*.ps,*.dvi
"set textwidth=80
set nofoldenable    " disable folding
set wildmode=list:longest
set fileencoding=utf-8

"To fix dark blue on black comments in vim:
highlight comment ctermfg=blue
highlight comment guifg=21

" Salida HTML (tambien con :TOhtml)
nmap <Leader>so :so $VIMRUNTIME/syntax/2html.vim<CR>

" Fix pasting:
inoremap <silent> <C-b> <ESC>u:set paste<CR>.:set nopaste<CR>gi

" Highlight redundant whitespace and tabs.
highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\| \+\ze\t/

" Cabecera bash scripts
fun! InsertHeadBash()
    normal(1G)
    call append(0, "#!/bin/bash")
    call append(1, "# Created: " . strftime("%c"))
    call append(2, "# Author: ")
    call append(3, "# Info: ")
    normal($)
endfun
map <Leader>sh :call InsertHeadBash()<cr>A
au BufNewFile,BufRead *.sh if getline(1) == "" | normal ,sh

" Cabecera python scripts
fun! InsertHeadPython()
    normal(1G)
    call append(0, "#!/usr/bin/env python")
    call append(1, "#-*- coding: utf-8 -*-")
"    call append(2, "# Created: " . strftime("%c"))
    normal($)
endfun
map <Leader>py :call InsertHeadPython()<cr>A
au BufNewFile,BufRead *.py if getline(1) == "" | normal ,py

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" e-acute (Ã©) en vim editando .tex
imap <C-.> <Plug>Tex_InsertItemOnThisLine

" spell check
nmap <Leader>spes :set spell spelllang=es<CR>
nmap <Leader>spen :set spell spelllang=en<CR>

" new window
nmap <C-t> :vsplit<CR>:e<SPACE>
imap <C-t> <Esc>:vsplit<CR>:e<SPACE>
" nmap <C-t> :vsplit<CR>
" imap <C-t> <Esc>:vsplit<CR>

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    "filetype plugin on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Sytastic ################################################################

" General
" Keybinding check: Issues checking on writ for PHP
nnoremap <F5> :w!<BAR>:SyntasticCheck<CR>
" Alway populate error window
let g:syntastic_always_populate_loc_list = 1
" Automatic check on open file (New  buffer)
let g:syntastic_check_on_open=1
" Automatic check on :wq | :x | :zz
let g:syntastic_check_on_wq = 0
" Error msg verbosity
let g:syntastic_quiet_messages = { "level": [] }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" Multilanguaje files stacking errors
let g:syntastic_aggregate_errors = 1
" Open errors window auto, and close it auto when no errors found
let g:syntastic_auto_loc_list=1
" Max error height relative to number of errors
let g:syntastic_loc_list_height=5
" Autojump cursor to first error (EE)
let g:syntastic_auto_jump = 0
" Mode definition. Active: On open r write. Passive keybind
let g:syntastic_mode_map = { "mode": "active",
                               \ "active_filetypes": ["html", "php", "javascript", "yaml"],
                               \ "passive_filetypes": ['sh'] }
" Debugging syntastic
let g:syntastic_debug = 0

" PHP
let g:syntastic_php_checkers = ["php"]
" HTML Needs Type (apt-get)
let g:syntastic_html_checkers = ["tidy"]
" JS Needs jshint: node.js/npm install jshint
let g:syntastic_javascript_checkers = ["jshint"]
  " Might be needed if Syntastic doesn't find jshint (/usr/local/bin/jshint)
  " let g:syntastic_javascript_jshint_exec='/usr/local/bin/jshint'
" JSON Currently using jshint
" let g:syntastic_json_checkers = ["jsonlint"]
" Bash [checkbashisms, sh, shellcheck]
 "let g:syntastic_enable_sh_checker = 1
let g:syntastic_sh_checkers = ["shellcheck"]
" YAML
let g:syntastic_yaml_checkers = ["js-yaml"]

" Look and feel
" Status window
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" Error symbol definitons
" let g:syntastic_warning_symbol = 'WW'
" let g:syntastic_error_symbol = 'EE'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" Enable symbols to mark errors
let g:syntastic_enable_signs=1
" Link SYntastic error marker to system color
highlight link SyntasticError Error
"highlight SyntasticWarningSign ctermbg=9
