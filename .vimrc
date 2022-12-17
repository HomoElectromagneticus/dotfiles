" here be my vim settings
" be iMproved
set nocompatible                "in compatible mode, lots of plugins don't work

" disallow vim to detect file types (required for plugins to work). note that
" this will be re-allowed once we have loaded vim plugins below
filetype off

" set the runtime path to include Vundle, fzf, and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()

" let Vundle handle Vundle and plugins. Add / enable plugins by adding
" `Plugin 'blahblah/blahblah'` here
Plugin 'VundleVim/Vundle.vim'
Plugin 'fladson/vim-kitty'      "syntax highlighting for kitty.conf
Plugin 'airblade/vim-gitgutter' "a gutter with git add/del/mod markers
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-vinegar'      "improves netrw (file browser) a bit
Plugin 'ziglang/zig.vim'        "official zig plugin
Plugin 'junegunn/fzf.vim'       "fuzzy finder vim integration

" All of your Plugins must be added before the following line
call vundle#end()               "required
filetype plugin indent on       "required (re-enables filetype detection etc.)

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

" move in 'editor lines' instead of file lines (useful for long lines with 
" wrapping text)
noremap j gj
noremap k gk
vmap j gj
vmap k gk

" status bar stuff
set ruler	          "always show the current position in the file
set laststatus=2	  "always show the statusbar

" enable syntax highlighting and the official solarized colors
syntax enable
set background=light
colorscheme solarized
" enable italics (this must come immediately after colorscheme)
highlight Comment cterm=italic gui=italic

" enable copy and paste into and out of the system clipboard
set clipboard=unnamed

" allow the backspace key to delete indents, end-of-line markers, and text 
" that existed before entering insert mode
set backspace=indent,eol,start

" turn on spell checking for english and french
set spell spelllang=en,fr
" but don't check for capitalization
set spellcapcheck=
" make the spell check just 'undercurl' the words (falls back to underline
" when undercurl is not available
hi SpellBad ctermfg=None ctermbg=None cterm=undercurl

" force the window to always show four lines above and below the cursor
set scrolloff=4

" allow the mouse wheel to scroll vim and not the whole terminal window
set mouse=a

" settings for searching
set hlsearch               "highlight my search
set ignorecase             "when searching
set incsearch              "incremental search
set smartcase              "...unless I use an uppercase character
set wrapscan               "set the search scan to wrap around the file

" setting some sane defaults for tabs (note that this behavior is likely 
" overwritten per filetype. see the '.vim/ftplugin/' folder
set expandtab             "use spaces for tabs

" set nice characters in case we want to see certain whitespace things like
" tabs and end-of-line characters
set listchars=eol:⏎,tab:▷·,trail:·

" Everyone tells me this setting is important, but I don't yet know why
set hidden

" Tab completion for opening files etc
set wildmode=longest,list,full
set wildmenu

" Cursor config
let &t_EI="\<Esc>[1 q"     "normal mode: blinking block
let &t_SR="\<Esc>[1 q"     "replace mode: blinking block (replace '1' with
                           "'3' to get an underline)
let &t_SI="\<Esc>[5 q"     "insert mode: blinking vertical line

" Set a simple line at column 80th to show 'hey this the limit for length'
set colorcolumn=80
" Try to nicely do soft line wrapping. We want to see that a line has been 
" wrapped, but we also don't want to break indenting etc...
set showbreak=↳\           "use this funny arrow character and a space to show
                           "linebreaks when they happen
set breakindent            "try to follow indenting when soft wrapping

" vim-gitgutter config stuff
set updatetime=400        "git gutter stuff will update every 400ms
" make the SignColumn colors nicer
highlight SignColumn guibg=lightgrey ctermbg=lightgrey
set signcolumn=yes        "always show the SignColumn

" Netrw (vim's file explorer) settings
" Ensure the working directory and the browsing directory are the same
let g:netrw_keepdir = 1
" Use the 'tree' listing as the default
let g:netrw_liststyle = 3
" Sets the default size of netrw when opened
let g:netrw_winsize = 28

" zig plugin settings
" disable automatic formatting on save (for the time being!)
let g:zig_fmt_autosave = 0

