" ---------------------  Vundle config part  ---------------------
set nocompatible
filetype off

" add Vundle to runtime path and init
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" say tu vundle to manage itself
Plugin 'gmarik/Vundle.vim'

" installed plugins
" Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'scrooloose/nerdtree'
" Plugin 'dense-analysis/ale'
" let g:ale_linters = {'markdown': ['languagetool','proselint']}
" let g:ale_languagetool_executable = '~/s/LanguageTool-4.9.1/langtool'
Plugin 'rust-lang/rust.vim'
Plugin 'stephpy/vim-yaml'
Plugin 'tikhomirov/vim-glsl'
Plugin 'matze/vim-move'
let g:move_key_modifier = 'C'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
Plugin 'dhruvasagar/vim-table-mode'
let g:table_mode_corner = "|"
Plugin 'vim-scripts/restore_view.vim'
"Plugin 'lervag/vimtex'
"let g:tex_flavor='latex'
"let g:vimtex_view_method='mupdf'
"let g:vimtex_quickfix_mode=0
"let g:tex_conceal='abdmg'
"Plugin 'sirver/ultisnips'
"let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsJumpForwardTrigger = '<tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'tpope/vim-abolish'
Plugin 'arcticicestudio/nord-vim'
"Plugin 'bwasti/vim-multiuser'
Plugin 'ajh17/VimCompletesMe'
Plugin 'kovisoft/paredit'
" Plugin 'l04m33/vlime', {'rtp': 'vim/'}
" au FileType lisp,scheme map <space> ))))))))))))))))))))))))))))))):call vlime#plugin#SendToREPL(vlime#ui#CurExprOrAtom())<CR>:call search('^[^;]\+')<CR>
"au FileType lisp,scheme map <space> :call vlime#plugin#SendToREPL(vlime#ui#CurTopExpr())<CR>
;
Plugin 'itchyny/vim-haskell-indent'
" Plugin 'jpalardy/vim-slime'
"let g:slime_target = "x11"


" plugins for text object
Plugin 'kana/vim-textobj-user'
" search text object plugin at https://github.com/kana/vim-textobj-user/wiki
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-line'
Plugin 'sgur/vim-textobj-parameter'

" end of vundle part
call vundle#end()

" --------------------- personnal config part ---------------------
colorscheme nord

" termguicolors
if has("termguicolors")
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set background=dark
    set t_Co=256
endif

"set guifont=monospace:h15

filetype plugin indent on
" Switch syntax highlighting on, when the terminal has colors
syntax on

" if a file is chosed, go to its directory
let filedir=expand("%:p:h")
if !empty(filedir) | exec "cd ".filedir | endif

" find git root dir
let gitdir=system("git rev-parse --show-toplevel 2>/dev/null | tr -d '\\n'")
if !empty(filedir) | exec "cd ".gitdir | endif

" java linter
if !empty(gitdir) | exec "let g:ale_java_javac_classpath = \"".gitdir."/src\"" | endif

" view (vim save currend position in file and folds)
set viewoptions=cursor,folds,slash,unix
if !empty(gitdir) | exec "set viewdir=".gitdir."/.git/view" | endif

set wildmenu            " display menu when searching

" create tag file
if empty(gitdir)
    command! MakeTags echo "git folder not found"
else
    exec "set tags=".gitdir."/.git/tags"
    exec "command! MakeTags !cd ".gitdir."/.git; ctags -R .."
endif

" search in subfolders
set path=**
set wildignore+=**/target/**

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"set nobackup           " do not keep a backup file, use versions instead
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
"set hlsearch           " highlight search
set number              " show line number at left
"set relativenumber      " show distance from current line at left
set mouse=a             " enable mouse usage if possible
"set ttymouse=sgr        " needed for enabling mouse with alacritty
set tabpagemax=100      " set number of tabs
"set hlsearch           " Also switch on highlighting the last used search pattern.
set updatetime=250      " vim update time, useful for gitgutter
set undofile            " keep undo history
set undodir=~/.vim/undo/
set conceallevel=2      " replacement of characters
set display+=lastline
set hidden              " permit to change file without saving the current one

"to see the possible colors :so $VIMRUNTIME/syntax/hitest.vim
set statusline=%#DiffText#%f\ %#TabLine#%=%#DiffAdd#\ %m%r%y\ char:%3b\ column:%3c\ %p%% 

" enhance tab
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" map nerd tree
map <C-n> :NERDTreeToggle<CR>

" show tabs and trailing spaces
exec "set listchars=trail:\uB7,tab:\uBB\uBB"
set list

" set clipboard to X11
set clipboard=unnamed

" set spell checking
"set spell
"set complete+=kspell

" make cursor line visible
set cursorline
hi cursorline cterm=none
hi cursorlinenr cterm=reverse

"latexmk
"map \ll <silent> exec "!latexmk -pdf -pvc ".expand("%")." >/dev/null 2>&1 &"

" avoid Ex mode
nnoremap Q <nop>

" spelling
autocmd FileType markdown setlocal spell
