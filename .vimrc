" Ref: https://github.com/junegunn/vim-plug
" Installation:
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

call plug#begin(expand('~/.vim/plugged'))

Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'nightsense/carbonized'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'jelera/vim-javascript-syntax'
Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'sjl/badwolf'
Plug 'tomasiser/vim-code-dark'
Plug 'bfrg/vim-cpp-modern'
Plug 'stephpy/vim-yaml'
Plug 'Yggdroot/indentLine'
Plug 'pseewald/vim-anyfold'
call plug#end()
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}

let g:lightline = {
\    'colorscheme': 'jellybeans',
\    'component_function': {
    \   'filename': 'LightlineFilename',
    \},
\ }

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let g:indentLine_char = '▏'
let g:onedark_termcolors=256
"filetype plugin indent on
syntax on
"autocmd Filetype * AnyFoldActivate
"set foldlevel=1
colorscheme jellybeans
syntax on
set t_Co=256
set laststatus=2
set number
set tabstop=4
set shiftwidth=4
set expandtab
set noshowmode
set encoding=utf-8
"set relativenumber
set cursorline
