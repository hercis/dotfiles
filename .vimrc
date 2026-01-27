set ruler
set showmode
set listchars+=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

set number
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch
"set nowrapscan
"set splitright
"set splitbelow

set scrolloff=2
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab

set fileformat=dos
set shortmess-=S " Show search count
set cinoptions+=j1 " Indent java anonymous classes

autocmd FileType help noremap <buffer> q :q<cr>
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

let mapleader=","
nnoremap <Leader>, ,

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :b<Space>
nnoremap <Leader>h :help<Space>

nnoremap <Leader>s :%s///g<Left><Left><Left>
vnoremap <Leader>s :s///g<Left><Left><Left>

" Insert empty line above current line
"nnoremap <M-o> m`O<Esc>``
nnoremap <Leader>O m`O<Esc>``

" Paste from yank register
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
vnoremap <Leader>p "0p
vnoremap <Leader>P "0P

" Don't store the deleted text in any register
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d

" Move to the next capital letter"
nnoremap ]U :call FindNextUppercase()<CR>
nnoremap [U :call FindPrevUppercase()<CR>

function! FindNextUppercase()
  call search('[A-Z]', 'W')
  if v:hlsearch
    nohlsearch
  endif
endfunction

function! FindPrevUppercase()
  " 'bW' flags: 'b' for backward, 'W' to prevent wrapping/highlight side effects
  call search('[A-Z]', 'bW')
  if v:hlsearch
    nohlsearch
  endif
endfunction

" Cursor shape
if &term =~ 'xterm' || &term =~ '256color' || has("win32unix")
  " Git Bash, MSYS2, or plain terminal Vim fallback
  let &t_SI = "\e[5 q"  " Insert: vertical bar
  let &t_SR = "\e[3 q"  " Replace: underline
  let &t_EI = "\e[1 q"  " Normal: block
  let &t_ti .= "\e[1 q" " Startup: block
  let &t_te .= "\e[0 q" " Exit: restore default
elseif has('gui_running') || exists('+guicursor')
  " Modern cursor shape (GVim, Neovim, etc.)
  " Note: Ideally, this should be the first if condition,
  " but the logic is not functioning as expected when running in Git Bash.
  set guicursor=n-v-c:block-blinkon1,i-ci-ve:ver25-blinkon1,r-cr-o:hor20-blinkon1
  "set guicursor=n-v-c:block-blinkon1,i-ci-ve:ver25-blinkon1,r-cr:hor20-blinkon1,o:hor50-blinkon1
endif

" https://github.com/morhetz/gruvbox
set background=dark 
autocmd vimenter * ++nested colorscheme gruvbox

" https://github.com/k-takata/minpac
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('morhetz/gruvbox')
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

function! PackList(...)
  call PackInit()
  return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

command! -nargs=1 -complete=custom,PackList
      \ PackOpenDir call PackInit() | call term_start(&shell,
      \    {'cwd': minpac#getpluginfo(<q-args>).dir,
      \     'term_finish': 'close'})

