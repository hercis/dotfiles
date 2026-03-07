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

set expandtab
set scrolloff=2 tabstop=2 shiftwidth=2 softtabstop=2

set fileformat=dos
set shortmess-=S " Show search count
set cinoptions+=j1 " Indent java anonymous classes

if has('termguicolors')
  set termguicolors
endif

autocmd FileType help noremap <buffer> q :q<cr>
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" Map leader to comma
let mapleader=","
nnoremap <Leader>, ,

nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>r :source %<CR>
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
"nnoremap ]U :call FindChar('[A-Z]', 'W')<CR>
"nnoremap [U :call FindChar('[A-Z]', 'bW')<CR>

" Jump to the previous unmatched }
nnoremap [} :call FindChar('}', 'bW')<CR>

" Jump to the previous unmatched {
nnoremap ]{ :call FindChar('{', 'W')<CR>

function! FindChar(pattern, flags)
  call search(a:pattern, a:flags)
  if v:hlsearch
    nohlsearch
  endif
endfunction

" https://github.com/bkad/CamelCaseMotion
let g:camelcasemotion_key = '<Leader>'

" https://github.com/justinmk/vim-sneak
"let g:sneak#label = 1

" Cursor shape
if !has('gui_running')
  let &t_SI = "\e[5 q"  " Insert: vertical bar
  let &t_SR = "\e[3 q"  " Replace: underline
  let &t_EI = "\e[1 q"  " Normal: block
  let &t_ti .= "\e[1 q" " Startup: block
  let &t_te .= "\e[0 q" " Exit: restore default
else 
  set guicursor=n-v-c:block-blinkon500-blinkoff500,i-ci-ve:ver25-blinkon500-blinkoff500,r-cr-o:hor20-blinkon500-blinkoff500

  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=l
  set guioptions-=b
endif

" https://github.com/Chromosore/vim-inkpot-refilled
colorscheme inkpot

" https://github.com/k-takata/minpac
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-surround')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('tommcdo/vim-exchange')
  call minpac#add('bkad/CamelCaseMotion')
  call minpac#add('Chromosore/vim-inkpot-refilled')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

function! PackList(...)
  call PackInit()
  return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

command! -nargs=1 -complete=custom,PackList
      \ PackOpenDir call PackInit() | call term_start(&shell,
      \    {'cwd': minpac#getpluginfo(<q-args>).dir,
      \     'term_finish': 'close'})

