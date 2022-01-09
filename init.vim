" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set number
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set incsearch           " do incremental searching
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
set mouse=a
set history=50          " keep 50 lines of command line history
set tabpagemax=100      " set number of tabs
set updatetime=250      " vim update time, useful for gitgutter
set undofile            " keep undo history
set undodir=~/.local/share/nvim/undo/
set hidden              " permit to change file without saving the current one
set display+=lastline
set wildmenu            " display menu when searching
set ruler               " show the cursor position all the time
set completeopt=menu,menuone,noinsert,noselect
set shortmess+=c
"let loaded_matchparen = 1
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
"set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
"set nowrap "No Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders

" Turn off paste mode when leaving insert
"autocmd InsertLeave * set nopaste

" Add asterisks in block comments
"set formatoptions+=r

"}}}

" Saves and directories "{{{
" ---------------------------------------------------------------------
" if a file is chosed, go to its directory
let filedir=expand("%:p:h")
if !empty(filedir) | exec "cd ".filedir | endif

" find git root dir
let gitdir=system("git rev-parse --show-toplevel 2>/dev/null | tr -d '\\n'")
if !empty(gitdir) | exec "cd ".gitdir | endif

" view (vim save currend position in file and folds)
set viewoptions=cursor,folds,slash,unix
if !empty(gitdir) | exec "set viewdir=\"".gitdir."/.git/view\"" | endif

if !empty(filedir)
  set path+=**
  set wildignore+=**/target/**
endif

" create tag file
"if empty(gitdir)
"    command! MakeTags echo "git folder not found"
"else
"    exec "set tags=".gitdir."/.git/tags"
"    exec "command! MakeTags !cd ".gitdir."/.git; ctags -R .."
"endif

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
hi cursorline cterm=none
hi cursorlinenr cterm=reverse
"set cursorcolumn

" show tabs and trailing spaces
exec "set listchars=trail:\uB7,tab:\uBB\uBB"
set list

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

"autocmd FileType norg setlocal shiftwidth=1 tabstop=1

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  else
    set clipboard=unnamed
  endif
endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors")
  syntax enable
  set termguicolors
  set background=dark
  " Use Monokai_pro
  colorscheme monokai_pro


  if exists("&winblend")
    set winblend=15
    set pumblend=15
  endif
endif

"}}}
