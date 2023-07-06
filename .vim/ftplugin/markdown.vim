" settings for markdown files (.md)

" turn on automatic softwrapping
setlocal wrap

" since we have softwrapping, we can add a couple more shortcuts to simplify
" navigation
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$

" ensure the softwrapping don't break a word apart
setlocal linebreak

" don't convert tabs to spaces 
setlocal noexpandtab

" every wrapped line will visually follow the line above it, and we will hide
" the linewrap character
setlocal breakindent
setlocal breakindentopt=sbr,list:-1
setlocal showbreak= 

" do not show a line at character 80 since we're softwrapping anyway
setlocal colorcolumn=

" enable italics (in markdown, are linked to the htmlItalic highlight group)
highlight htmlItalic cterm=italic gui=italic
