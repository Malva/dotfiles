scriptencoding utf-8

"----------------------------------------------------------------------
" NeoBundleの設定 {{{
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'

NeoBundle 'Shougo/neocomplete.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/emmet-vim'

NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'othree/yajs.vim'
NeoBundle 'ujihisa/unite-colorscheme'

NeoBundle 'mattn/invader-vim'
NeoBundle 'rbtnn/game_engine.vim'
NeoBundle 'rbtnn/puyo.vim'

call neobundle#end()
" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" }}} ----------------------------------------------------------------------
" vimproc {{{
" Windows環境でvimprocがロードされたときにGitHubからDLLをダウンロードor
" アップグレードする。
if has('Windows')
  let g:vimproc#download_windows_dll = 1
endif

" }}} ----------------------------------------------------------------------
" NeoComplete {{{

" +luaなvimの起動時にNeoComplete.vimをONにする。
if has('lua')
  let g:neocomplete#enable_at_startup = 1
endif

let s:neco_dicts_dir = $HOME . '/dicts'
if isdirectory(s:neco_dicts_dir)
  let g:neocomplete#sources#dictionary#dictionaries = {
        \   'ruby': s:neco_dicts_dir . '/ruby.dict',
        \   'javascript': s:neco_dicts_dir . '/jquery.dict',
        \ }
endif

" }}} ----------------------------------------------------------------------
" QuickRun {{{
"let g:quickrun_config={'*': {'vsplit': ''}}
"set splitright

" }}} ----------------------------------------------------------------------
" yajs.vim {{{
NeoBundleLazy 'othree/yajs.vim', {'autoload':{'filetypes':['javascript']}}
augroup yajsCmd
  autocmd!
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript
augroup END

" }}} ----------------------------------------------------------------------
" Indent-Guides {{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_indent_levels=20
" let g:indent_guides_soft_pattern=' '
let g:indent_guides_exclude_filetypes=['help', 'nerdtree']

" }}} ----------------------------------------------------------------------
" settings {{{
set encoding=utf-8
set fileencoding=utf-8
set autoread
set showcmd

set ignorecase
set smartcase
set incsearch

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

set backspace=indent,eol,start
set wrapscan
set showmatch
set wildmenu
set formatoptions+=mM
set ambiwidth=double

set cursorline
set number
set ruler
set nolist
"set listchars=tab:>-,extends:<,trail:-,eol:$
set nowrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set splitright

"----------------------------------------------------------------------
set t_Co=256
set visualbell t_vb=
set hlsearch
set backup
set backupdir=$HOME/.vim/vimbackup
set swapfile
" http://vim-jp.org/vim-users-jp/2009/06/26/Hack-32.html
" set directory-=.
set directory=~/.vim/tmp
" http://vim-jp.org/vim-users-jp/2010/07/19/Hack-162.html
"if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
"endif

" }}} ----------------------------------------------------------------------
" mappings {{{

" <Leader>に<Space>を設定する
let mapleader=" "

nnoremap <Leader>.
      \       :<C-u>tabe $MYVIMRC<CR>
nnoremap <Leader>.g
      \       :<C-u>tabe $MYGVIMRC<CR>
nnoremap <Leader>s.
      \       :<C-u>source $MYVIMRC<CR>
nnoremap <Leader>s.g
      \       :<C-u>source $MYGVIMRC<CR>

nnoremap <Leader>m   :<C-u>marks
" nnoremap <Space>r   :<C-u>registers

nnoremap <Leader>ow
      \        :<C-u>setlocal wrap!
      \       \|     setlocal wrap?<CR>

"nnoremap <Leader>ig :<C-u>IndentGuidesToggle<CR>

nnoremap j gj
nnoremap k gk

" <C-l>による再描画の際、ハイライトを消去する。
nnoremap <C-l> :<C-u>nohlsearch<CR><C-l>

inoremap <C-l> <ESC>
inoremap ;: <End>
inoremap ;l <Home>

" inoremap () ()<left>
" inoremap {} {}<left>
" inoremap [] []<left>
" inoremap <> <><left>
" inoremap '' ''<left>
" inoremap "" ""<left>

inoremap {<CR> {<CR><CR>}<Up><End>

"----------------------------------------------------------------------
" :make % はRuby,Perl等にしか対応していないため、ファイルタイプによって
" mekeの引数を変える必要がある。
nnoremap <silent> <F5> :<C-u>make!<Space>%<CR>:<C-u>cw<CR>

" }}} ----------------------------------------------------------------------
" Visualization of double-byte space {{{
augroup highlightIdeographicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=Yellow guibg=DarkYellow
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

colorscheme molokai   " gvim使用時はgvimrcを編集すること
syntax on

"function! ZenkakuSpace()
"    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
"endfunction
"
"if has('syntax')
"    augroup ZenkakuSpace
"        autocmd!
"        autocmd ColorScheme * call ZenkakuSpace()
"        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
"    augroup END
"    call ZenkakuSpace()
"endif

" }}} ----------------------------------------------------------------------
" compiler {{{
augroup compilerSet
  autocmd!
  autocmd FileType c,cpp :compiler gcc
  autocmd FileType ruby :compiler ruby
  autocmd FileType perl,cgi :compiler perl
augroup END

" }}} ----------------------------------------------------------------------

" vim: expandtab tabstop=8 softtabstop=2 shiftwidth=2 textwidth=0:
" vim: foldmethod=marker
