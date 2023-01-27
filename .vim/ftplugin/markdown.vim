" settings for text files (txt)

" turn on automatic softwrapping
setlocal wrap

" set the softwrapping 'edge' at 80 characters
"setlocal columns=80

" ensure the softwrapping don't break a word apart
setlocal linebreak

" don't convert tabs to spaces 
setlocal noexpandtab

" every wrapped line will visually follow the line above it, and we will hide
" the linewrap character
setlocal breakindent
setlocal showbreak= 

" do not show a line at character 80 since we're softwrapping anyway
setlocal colorcolumn=

