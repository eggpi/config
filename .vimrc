" Ivan Sichmann Freitas <ivansichfreitas (_at_) gmail (_dot_) com>
" Guilherme P. Gonçalves <guilherme.p.gonc (_at_) gmail (_dot_) com>

set nocompatible " VIM POWER!!!!

" Enable parsing .vimrc in the current directory.
set exrc
set secure

set modeline
set modelines=10

set encoding=utf8

" Backup and history options
set backupdir=~/.vim/backup " Put backup files in another directory.
set undodir=~/.vim/undodir " Same for undo files.
set undofile
set history=1000 " Increase history size
set background=light " Set best color scheme to dark consoles
set autoread " Automagically reloads a file if it was externally modified

set nowrap
set textwidth=80 " Break long lines at column 80

" Indentation
filetype plugin indent on

" Searching
set hlsearch
set ignorecase
set smartcase

" Better completion menu
set wildmenu
set wildmode=longest,list
set wildignore+=*.o,*.pyc,*.swp

if has("syntax")
	syntax on
endif

" Set hotkey for regenerating tags
map <C-c> :silent !ctags -f TAGS -R * >/dev/null 2>&1 & <CR>:redraw!<CR>

" Set hotkey to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Set hotkey to toggle TagBar
map <C-b> :TagbarToggle<CR>

" A more intuitive mapping for Y
map Y y$

" Highlight trailing whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

set listchars=tab:▷⋅

" Show commands as you type them
set showcmd

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Autowrite to buffers when hiding them
set autowrite

au BufRead,BufNewFile {*.textile} set ft=textile

call pathogen#infect()

" Spelling options
set spelllang=pt_br
highlight clear SpellBad SpellLocal
highlight SpellBad cterm=underline ctermfg=red

command -range Foldstrip <line1>,<line2>!paste -s -d " " - | fold -s | sed 's/ $//'

set statusline=%t%m\ %c\ %l/%L\ (%p%%)\ buffer:\ %n
set laststatus=2

if argc() == 2
    silent vertical all
endif
