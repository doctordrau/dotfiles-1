" Mouse Scrolling .. only in xterm (& maybe console) grr
set mouse=a " scrolling and clicking and stuff
map <M-Esc>[62~ <MouseDown>
map! <M-Esc>[62~ <MouseDown>
map <M-Esc>[63~ <MouseUp>
map! <M-Esc>[63~ <MouseUp>
map <M-Esc>[64~ <S-MouseDown>
map! <M-Esc>[64~ <S-MouseDown>
map <M-Esc>[65~ <S-MouseUp>
map! <M-Esc>[65~ <S-MouseUp>

map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
