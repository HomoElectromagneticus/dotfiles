" here be my vim settings
" be iMproved
set nocompatible "in compatible mode, lots of plugins don't work

" disallow vim to detect file types (required for plugins to work).
" note that this will be re-allowed once we have loaded vim plugins
" below
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle handle Vundle and plugins. Add / enable plugins by adding
" `Plugin 'blahblah/blahblah'` here
Plugin 'VundleVim/Vundle.vim'
Plugin 'fladson/vim-kitty'      " syntax highlighting for kitty.conf
Plugin 'airblade/vim-gitgutter' " a gutter with git add/del/mod markers
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()               " required
filetype plugin indent on       " required (re-enables filetype
                                " detection and etc.)
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" set encoding to UTF-8
set encoding=utf-8

" always show line numbers
set number

" disable the swap file
" set noswap

" move in 'editor lines' instead of file lines (useful for long lines 
" with wrapping text)
noremap j gj
noremap k gk
vmap j gj
vmap k gk

" enable 'Q' to format the current paragraph
nnoremap Q gwap

" status bar stuff
set ruler	        "always show the current position in the file
set laststatus=2	"always show the statusbar

" enable syntax highlighting and the official solarized colors
syntax enable
set background=light
colorscheme solarized
" enable italics (this must come immediately after colorscheme)
highlight Comment cterm=italic gui=italic

" enable copy and paste into and out of the system clipboard
set clipboard=unnamed

" allow the backspace key to delete indents, end-of-line markers,
" and text that existed before entering insert mode
set backspace=indent,eol,start

" turn on spell checking for english and french
set spell spelllang=en,fr
" but don't check for capitalization
set spellcapcheck=
" make the spell check just underline the words
hi SpellBad ctermfg=None ctermbg=None cterm=underline

" force the window to always show two lines above and below the cursor
set scrolloff=2

" allow the mouse wheel to scroll vim and not the whole terminal window
set mouse=a

" settings for searching
set hlsearch              "highlight my search
set incsearch             "incremental search
set wrapscan              "set the search scan to wrap around the file
set ignorecase            "when searching
set smartcase             "...unless I use an uppercase character

" setting some sane defaults for tabs (note that this behavior is
" likely overwritten per filetype. see the '.vim/ftplugin/' folder
set expandtab

" set nice characters in case we want to see certain whitespace things
" like tabs and end-of-line characters
set listchars=eol:⏎,tab:▷·,trail:·

" vim-gitgutter config stuff
set updatetime=400      "git gutter stuff will update every 400ms
" make the SignColumn colors nicer
highlight SignColumn guibg=lightgrey ctermbg=lightgrey
set signcolumn=yes      "always show the SignColumn
