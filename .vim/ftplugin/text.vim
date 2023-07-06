" settings for text files (txt)

" turn on automatic softwrapping
setlocal wrap

" set the softwrapping 'edge' at 80 characters
" this is actually dumb as it breaks the vim theme
"setlocal columns=80

" ensure the softwrapping don't break a word apart
setlocal linebreak

" don't convert tabs to spaces 
setlocal noexpandtab

" every wrapped line will visually follow the line above it
setlocal breakindent

