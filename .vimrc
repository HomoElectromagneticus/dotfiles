" here be my vim settings
" be iMproved
set nocompatible                "in compatible mode, lots of plugins don't work

" disallow vim to detect file types (required for plugins to work). note that
" this will be allowed again once we have loaded vim plugins below
filetype off

" set the runtime path to include fzf(required for fzf plugin) and initialize
set rtp+=/usr/local/opt/fzf
call plug#begin()

" let vim-plug handle and plugins. Add / enable plugins by adding
" `Plug 'blahblah/blahblah'` here
Plug 'fladson/vim-kitty'        "syntax highlighting for kitty.conf
Plug 'mhinz/vim-signify', { 'tag': 'legacy' }
Plug 'junegunn/goyo.vim'        "distraction-free writing
Plug 'tpope/vim-vinegar'        "improves netrw (file browser) a bit
Plug 'ziglang/zig.vim'          "official zig plugin
Plug 'junegunn/fzf.vim'         "fuzzy finder vim integration
Plug 'tpope/vim-fugitive'       "git functions in vim
Plug 'ap/vim-buftabline'        "show buffers at top of window
Plug 'neoclide/coc.nvim', {'branch': 'release'}     "fancy completion
" color themes
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'chiendo97/intellij.vim'

" All of your Plugins must be added before the following line
call plug#end()

filetype plugin indent on       "required (re-enables filetype detection etc.)
" Put your non-Plugin stuff after this line

" set encoding to UTF-8
set encoding=utf-8

" always show line numbers
set number

" move in 'editor lines' instead of file lines (useful for long lines with 
" wrapping text)
noremap j gj
noremap k gk
vmap j gj
vmap k gk

" Status line stuff. Nothing fancy!
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  " buffer no., filepath(tail), modified?, read-only, filetype, git branch (if
  " relevant), empty space, position in file, percent in file
  return '%.30f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

set laststatus=2	  "always show the statusbar

" enable syntax highlighting and set the theme
syntax enable
set background=light
" Custom settings for solarized
function! s:tweak_solarized_colors()
        "makes the signify column match the number column
        highlight SignColumn guibg=lightgrey ctermbg=lightgrey
        "makes selection in conqueror of completion menu visible
        highlight CocMenuSel ctermbg=15 ctermfg=8 guibg=Grey
endfunction
autocmd! ColorScheme solarized call s:tweak_solarized_colors()
" set the color theme
colorscheme PaperColor
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
" when undercurl is not available)
let &t_Cs = "\e[4:3m"                   "enable undercurl
let &t_Ce = "\e[4:0m"                   "enable undercurl
hi SpellBad ctermfg=None ctermbg=None cterm=undercurl gui=undercurl

" force the window to always show four lines above and below the cursor
set scrolloff=4
" force at minimum one column to stay visible when horizontal scrolling
set sidescrolloff=1

" allow the mouse wheel to scroll vim and not the whole terminal window
set mouse=a

" settings for searching
set hlsearch               "highlight my search
set ignorecase             "ignore letter case
set smartcase              "unless I use an uppercase character
set incsearch              "incremental search
set wrapscan               "set the search scan to wrap around the file

" setting some sane defaults for tabs (note that this behavior is likely 
" overwritten per filetype. see the '.vim/ftplugin/' folder
set expandtab              "use spaces for tabs

" set nice characters in case we want to see certain whitespace things like
" tabs and end-of-line characters
set listchars=eol:⏎,tab:▷·,trail:·

" Prevent vim from quitting without asking to save modified files
set hidden

" Nice tab completion for opening files etc
set wildmenu
set wildignorecase

" Cursor config
let &t_EI="\<Esc>[1 q"     "normal mode: blinking block
let &t_SR="\<Esc>[1 q"     "replace mode: blinking block (replace '1' with
                           "'3' to get an underline)
let &t_SI="\<Esc>[5 q"     "insert mode: blinking vertical line

" Set a simple line at column 80th to show 'hey this the limit for length'
set colorcolumn=80
" Try to nicely do soft line wrapping when it's on. We will see that a line has
" been wrapped because the line number will be missing.
set breakindent            "try to follow indenting when soft wrapping
set nowrap                 "do not soft wrap lines by default (this should be
                           "overridden per filetype)

" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" PLUGIN CONFIGURATIONS
" signify config stuff
set updatetime=400                      "vcs gutter will update every 400ms
set signcolumn=yes                      "always show the SignColumn
let g:signify_sign_show_count = 0       "don't know the number of del'd lines
let g:signify_sign_change = '~'         "use ~ to show a changed line

" Netrw (vim's file explorer) settings
let g:netrw_keepdir = 1                 "force working dir to equal browsing dir
let g:netrw_liststyle = 3               "Use the 'tree' listing as the default
" Sets the default size of netrw when opened as a new split
let g:netrw_winsize = 28

" Buftabline settings
let g:buftabline_numbers = 1            "show buffer number for ez navigation

" zig plugin settings
let g:zig_fmt_autosave = 0              "disable automatic formatting on save

" Conqueror of completion config (note that a lot of Coc's settings are 
" in ~/.vim/coc-settings.json and json files can't really be commented)
" GoTo code navigation (replaces default vim implementation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Goyo tweaks (force underline for spelling errors, and italics for comments.
" this fixes some minor annoyances when entering / exiting goyo mode)
function! s:goyo_enter()
  highlight Comment cterm=italic gui=italic
  hi SpellBad ctermfg=None ctermbg=None cterm=undercurl gui=undercurl
endfunction

function! s:goyo_leave()
  highlight Comment cterm=italic gui=italic
  hi SpellBad ctermfg=None ctermbg=None cterm=undercurl gui=undercurl
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
