" settings for text files (txt)

" turn on automatic softwrapping
setlocal wrap

" set the softwrapping 'edge' at 80 characters
setlocal columns=80

" ensure the softwrapping don't break a word
" apart
setlocal linebreak

" don't convert tabs to spaces (this is the default set in the
" .vimrc file
setlocal noexpandtab

" every wrapped line will visually follow the line above it
setlocal breakindent

