let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /repo/egugwen/github/nvim-config
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +132 /repo/egugwen/github/nvim-config/lua/config/vimopt.lua
badd +28 /repo/egugwen/github/redwood/absorb/scripts/utils.sh
badd +22 /repo/egugwen/github/redwood/mllp/src/learnpy/flow/query_ib.py
badd +105 /repo/egugwen/github/redwood/mllp/src/learnpy/utils/basicutils.py
badd +6 /repo/egugwen/dj/rensa2/util/elvis/classes/terminal.py
badd +1639 /repo/egugwen/dj/rensa2/nsi-pilot/chart.py
badd +767 /repo/egugwen/dj/rensa2/nsi-pilot/online_evaluation_runner.py
badd +236 /repo/egugwen/dj/rensa2/nsi-pilot/jenkins_query.py
badd +125 /repo/egugwen/dj/rensa2/nsi-pilot/gerrit.py
badd +15 /repo/egugwen/github/nvim-config/lua/setup/telescope.lua
argglobal
%argdel
edit /repo/egugwen/github/nvim-config/lua/setup/telescope.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
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
exe 'vert 2resize ' . ((&columns * 236 + 133) / 267)
argglobal
enew
file /repo/egugwen/github/nvim-config/lua/setup/NvimTree_1
balt /repo/egugwen/github/nvim-config/lua/setup/telescope.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
lcd /repo/egugwen/github/nvim-config/lua/setup
wincmd w
argglobal
balt /repo/egugwen/github/nvim-config/lua/config/vimopt.lua
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
let s:l = 15 - ((14 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 0
lcd /repo/egugwen/github/nvim-config/lua/setup
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 30 + 133) / 267)
exe 'vert 2resize ' . ((&columns * 236 + 133) / 267)
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
