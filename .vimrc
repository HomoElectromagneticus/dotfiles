" here be my vim settings
" be iMproved
set nocompatible                "in compatible mode, many plugins don't work

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
Plug 'tpope/vim-vinegar'        "improves netrw (file browser) a bit
Plug 'ziglang/zig.vim'          "official zig plugin
Plug 'junegunn/fzf.vim'         "fuzzy finder vim integration
Plug 'tpope/vim-fugitive'       "git functions in vim
"Plug 'ap/vim-buftabline'        "show buffers at top of window
Plug 'neoclide/coc.nvim', {'branch': 'release'}     "fancy completion
Plug 'lervag/wiki.vim'          "knowledge database / notes thing
Plug 'lervag/lists.vim'         "makes to do lists a bit simpler
Plug 'junegunn/goyo.vim'        "distraction-free writing in vim
" color themes
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'

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
set laststatus=2          "always show the status line

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
" make the spell check uses 'undercurl' the words (falls back to underline
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
" overwritten per filetype. see the '.vim/ftplugin/' folder)
set expandtab              "use spaces for tabs

" set nice characters in case we want to see certain whitespace things like
" tabs and end-of-line characters
set listchars=eol:⏎,tab:▷·,trail:·

" Prevent vim from quitting without asking to save modified files
set hidden

" keep temporary files used during saving etc in ~/tmp
set backupdir=~/tmp
set dir=~/tmp

" Nice tab completion for opening files etc
set wildmenu
set wildignorecase

" Cursor config
let &t_EI="\<Esc>[1 q"     "normal mode: blinking block
let &t_SR="\<Esc>[1 q"     "replace mode: blinking block (replace '1' with
                           "'3' to get an underline)
let &t_SI="\<Esc>[5 q"     "insert mode: blinking vertical line

" Set a line at column 80th to show 'hey this the limit for length'
set colorcolumn=80
" Try to nicely do soft line wrapping when it's on
set breakindent            "try to follow indenting when soft wrapping
set nowrap                 "do not soft wrap lines by default (this should be
                           "overridden per filetype)

" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" use ripgrep for vimgrep if ripgrep exists
if executable('rg') | set grepformat+=%f:%l:%c:%m grepprg=rg | endif

" titlebar stuff - show the filename of the current buffer (nice for goyo)
set title
set titlestring=%-25.55F\ %a%r%m titlelen=74

" PLUGIN CONFIGURATIONS
" signify config stuff
set updatetime=400                      "vcs gutter will update every 400ms
set signcolumn=yes                      "always show the SignColumn
let g:signify_sign_show_count = 0       "don't know the number of del'd lines
let g:signify_sign_change = '~'         "use ~ to show a changed line

" Netrw (vim's file explorer) settings
let g:netrw_keepdir = 1                 "force working dir to equal browsing dir
let g:netrw_liststyle = 3               "use the 'tree' listing as the default
" Sets the default size of netrw when opened as a new split
let g:netrw_winsize = 28

"" Buftabline settings
"let g:buftabline_numbers = 1            "show buffer number for ez navigation
"let g:buftabline_indicators = 1         "show if a buffer has been modified

"" zig plugin settings
let g:zig_fmt_autosave = 0              "disable automatic formatting on save

"" Conqueror of completion config (note that a lot of Coc's settings are 
" in ~/.vim/coc-settings.json and json files can't really be commented)
" GoTo code navigation (replaces default vim implementation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"" wiki.vim configuration
" specify the root directory of your personal wiki (open with <leader>ww)
let g:wiki_root = '~/Documents/text-vault'
" set leader + t to run a command that will search for to-do items 'under' the
" text-vault folder and add them to vim's quickfix list. note that this assumes 
" that the to-do items all start with ` [ ]`. the quickfix list can be
" shown with `:cw`
nmap <leader>t :vimgrep /\s\[\s\]/j ~/Documents/text-vault/**.md<cr>

"" Goyo tweaks (mostly attached to entering and exiting goyo)
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! s:goyo_enter()
  "fixes italics problems in goyo
  highlight Comment cterm=italic gui=italic
  "fixes spellcheck highlighting
  hi SpellBad ctermfg=None ctermbg=None cterm=undercurl gui=undercurl
  "removes the tabline to be even more distraction-free
  "set showtabline=0
  "the below stuff enables quitting directly from goyo in certain cases 
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  "fixes italics
  highlight Comment cterm=italic gui=italic
  "fixes spellcheck highlighting
  hi SpellBad ctermfg=None ctermbg=None cterm=undercurl gui=undercurl
  "turns back on the tabline and tells buftabline to update
  "set showtabline=2
  ":call buftabline#update(0)
  "quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
          qa!
      else
          qa
      endif
  endif
endfunction
" this makes goyo a little taller to better use all the screen real-estate
let g:goyo_height = 100

"" This function allows sending the output of a vim command to a fresh buffer
" see documentation at: https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" example usage: send the output of `:hi` to a new buffer: `:Redir hi`
function! Redir(cmd, rng, start, end)
    for win in range(1, winnr('$'))
       if getwinvar(win, 'scratch')
               execute win . 'windo close'
       endif
    endfor
    if a:cmd =~ '^!'
       let cmd = a:cmd =~' %'
               \ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
               \ : matchstr(a:cmd, '^!\zs.*')
       if a:rng == 0
               let output = systemlist(cmd)
       else
               let joined_lines = join(getline(a:start, a:end), '\n')
               let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
               let output = systemlist(cmd . " <<< $" . cleaned_lines)
       endif
    else
       redir => output
       execute a:cmd
       redir END
       let output = split(output, "\n")
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunction

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

