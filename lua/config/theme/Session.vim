let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /repo/egugwen/ws/bin/emacs-28.2
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +32 /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua
badd +0 /repo/egugwen/dj/config/nvim/lua/config/theme/palette.lua
argglobal
%argdel
edit /repo/egugwen/dj/config/nvim/lua/config/theme/palette.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 30 + 133) / 267)
exe '2resize ' . ((&lines * 35 + 37) / 74)
exe 'vert 2resize ' . ((&columns * 118 + 133) / 267)
exe '3resize ' . ((&lines * 35 + 37) / 74)
exe 'vert 3resize ' . ((&columns * 117 + 133) / 267)
exe '4resize ' . ((&lines * 35 + 37) / 74)
exe 'vert 4resize ' . ((&columns * 236 + 133) / 267)
argglobal
enew
file /repo/egugwen/dj/config/nvim/lua/config/theme/NvimTree_1
balt /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
lcd /repo/egugwen/dj/config/nvim/lua/config/theme
wincmd w
argglobal
balt /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 26 - ((25 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 26
normal! 0
lcd /repo/egugwen/dj/config/nvim/lua/config/theme
wincmd w
argglobal
if bufexists(fnamemodify("/repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua", ":p")) | buffer /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua | else | edit /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua | endif
if &buftype ==# 'terminal'
  silent file /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd /repo/egugwen/dj/config/nvim/lua/config/theme
wincmd w
argglobal
if bufexists(fnamemodify("/repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua", ":p")) | buffer /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua | else | edit /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua | endif
if &buftype ==# 'terminal'
  silent file /repo/egugwen/dj/config/nvim/lua/config/theme/hacker.lua
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 32 - ((15 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 32
normal! 0
lcd /repo/egugwen/dj/config/nvim/lua/config/theme
wincmd w
4wincmd w
exe 'vert 1resize ' . ((&columns * 30 + 133) / 267)
exe '2resize ' . ((&lines * 35 + 37) / 74)
exe 'vert 2resize ' . ((&columns * 118 + 133) / 267)
exe '3resize ' . ((&lines * 35 + 37) / 74)
exe 'vert 3resize ' . ((&columns * 117 + 133) / 267)
exe '4resize ' . ((&lines * 35 + 37) / 74)
exe 'vert 4resize ' . ((&columns * 236 + 133) / 267)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
