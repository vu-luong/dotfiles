"Minimum Minimum vimrc, used for ACM practices & real contest
" Settings that should be on by default
syntax on
set bg=light       " Dark background
set bs=2          " backspace should work as we expect
set autoindent
set ruler         " show cursor position in bottom line
set nu            " show line number
set hlsearch      " highlight search result
" y and d put stuff into system clipboard (so that other apps can see it)
set clipboard=unnamed,unnamedplus
" set nowrap
" set textwidth=10
" set cindent
" set timeoutlen=100

" Tab related stuffs
set shiftwidth=4  " tab size = 4
set expandtab
set softtabstop=4
" set shiftround    " when shifting non-aligned set of lines, align them to next tabstop

" Searching
set incsearch     " show first match when start typing
set ignorecase    " default should ignore case
set smartcase     " use case sensitive if I use uppercase
set guifont=Menlo:h14
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.jsx"
call plug#begin('~/.vim/plugged')

Plug 'crusoexia/vim-monokai'
Plug 'git://github.com/jsx/jsx.vim.git'
Plug 'critiqjo/lldb.nvim'
Plug 'gilligan/vim-lldb'
Plug 'NLKNguyen/papercolor-theme'
Plug 'scrooloose/nerdcommenter'
Plug 'leafgarland/typescript-vim'

" Add plugins to &runtimepath
call plug#end()
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
map <C-n> :NERDTreeToggle<CR>
set mouse=a

function! MyTabCompletion()
if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
return "\<C-P>"
else
return "\<Tab>"
endif
endfunction
inoremap <Tab> <C-R>=MyTabCompletion()<CR>
function! MyComment()
let l = getline('.')
if l =~ '^\s*\/\/'
let l = substitute(l, '\/\/', '', '')
else
let l = '//' . l
endif
call setline(line('.'), l)
endfunction
noremap <C-_> :call MyComment()<CR>

noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>
noremap <CR> o<Esc>
nnoremap <C-J> a<CR><Esc>k$
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

function! CPPSET()
nnoremap <buffer> <F9> :w<cr>:!g++ -g % -O2 -o %< -std=c++11 -I ./<cr>:!./%<<cr>
nnoremap <buffer> <F7> :w<cr>:!make %<<cr>:!./%<<cr>
nnoremap <buffer> <F8> :w<cr>:!g++ -g % -O2 -o %< -std=c++11 -I ./<cr>
nnoremap <buffer> <F10> <cr>:cd %:p:h<cr>
nnoremap <buffer> <F11> <cr>:!./%<<cr>
endfunction

function! PASCALSET() 
nnoremap <buffer> <F9> :w<cr>:!fpc %<cr>:!clear;./%<<cr>
endfunction

function! JAVASET()
nnoremap <buffer> <F8> :!javac %<cr>
nnoremap <buffer> <F9> :!javac %<cr>:!clear;java %< %<cr>
endfunction

function! NODEJSSET() 
nnoremap <buffer> <F9> :w<cr> :!clear;node %:t<cr>
endfunction

function! PYTHON()
nnoremap <buffer> <F9> :w<cr> :!clear;python %:t<cr>
endfunction

if has("gui_macvim")
    let macvim_hig_shift_movement = 1
    colorscheme monokai
endif
let g:NERDTreeWinSize=17
let g:NERDTreeWinPos = "right"

autocmd FileType cpp    call CPPSET()
autocmd FileType java   call JAVASET()
autocmd FileType javascript     call NODEJSSET()
autocmd FileType python call PYTHON()
autocmd FileType pascal call PASCALSET()
au BufNewFile,BufRead *.edp set filetype=edp

syntax on
set t_Co=256  " vim-monokai now only support 256 colours in terminal.

set notitle
set guioptions=
set nrformats= "treat all numerals as decimal, regardless of whether they are padded with zeros

execute pathogen#infect()
"autocmd VimEnter * NERDTree

" first, enable status line always
set laststatus=2

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif
