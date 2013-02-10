" Toggle fold state between closed and opened with spacebar
" If there is no fold at current line, just moves forward.
" If it is present, reverse it's state.
fun! ToggleFold()
if foldlevel('.') == 0
normal! l
else
if foldclosed('.') < 0
. foldclose
else
. foldopen
endif
endif
" Clear status line
echo
endfun

noremap <space> :call ToggleFold()<CR> 


" specific language helpers
syn keyword htmlArg contained onclick

" SVN shit
au BufNewFile,BufRead  svn-commit.* setf svn


