" ---------------------------------------------------------------------------------------
"  .vimrc
"  @tasasaki
" ---------------------------------------------------------------------------------------

" ---------------------------------------------------------------------------------------
" setup
" ---------------------------------------------------------------------------------------
"{{{
set nocompatible
set lazyredraw
set notitle
set whichwrap=b,s,h,l,<,>,[,]
set runtimepath+=$HOME/.conf/.vim/vimfiles
"set verbose=9
"}}}

" ---------------------------------------------------------------------------------------
" color
" ---------------------------------------------------------------------------------------
"{{{
syntax on

colorscheme desert

highlight LineNr ctermfg=darkgrey
highlight NonText ctermfg=darkyellow
highlight Folded ctermfg=blue
highlight SpecialKey cterm=underline ctermfg=darkgrey

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

highlight LastSpace cterm=underline ctermfg=red guibg=white
match LastSpace /( )+$/
"}}}

" ---------------------------------------------------------------------------------------
" input
" ---------------------------------------------------------------------------------------
"{{{
" tab, indent
set tabstop=4
set shiftwidth=4
set softtabstop=0
set autoindent smartindent
"set expandtab
set cindent
set shiftround
"set list
"set listchars=tab:>-,extends:<

" support
set backspace=2
set formatoptions+=m
set showmatch
set scrolloff=5
set clipboard=unnamed
set foldmethod=marker

" command
set wildmenu
set wildmode=list:full
set showcmd
"}}}

" ---------------------------------------------------------------------------------------
" search
" ---------------------------------------------------------------------------------------
"{{{
set wrapscan
set ignorecase
set smartcase
set nohlsearch
set incsearch
"}}}

" ---------------------------------------------------------------------------------------
" key bynd
" ---------------------------------------------------------------------------------------
"{{{
nnoremap j gj
nnoremap k gk
nnoremap / :/
nnoremap ? g?
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <BS> i<BS>
nnoremap <CR> i<CR>
nnoremap <F2> :set number! number?<CR>

" brackets"
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>
inoremap <C-j> <ESC>

vnoremap j gj
vnoremap k gk
"}}}

" ---------------------------------------------------------------------------------------
" encode
" ---------------------------------------------------------------------------------------
"{{{
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set ambiwidth=double
"}}}

" ---------------------------------------------------------------------------------------
" status
" ---------------------------------------------------------------------------------------
"{{{
set statusline=%n:\ %-30.30f\ %16(\ %m%r%{GetEFstatus()}\ %)%=%4l/%4L\ \ 
set laststatus=2

function! GetEFstatus()
   let str = ''
   let fenc = ''
   if &fileformat == 'unix'
      let str = '[UNI]'
   else
      let str = '[' . &fileformat . ']'
   endif
   if &fileencoding != ''
      if &fileencoding =~# 'iso-2022-jp'
         let fenc = 'J'
      elseif &fileencoding == 'utf-8'
         let fenc = 'U'
      elseif &fileencoding == 'cp932'
         let fenc = 'S'
      elseif &fileencoding =~# 'euc-jp'
         let fenc = 'E'
      else
         let fenc = &fileencoding
      endif
      let str = str . '[' . fenc . ']'
   else
      let str = str . '[-]'
   endif
   unlet fenc
   return str
endfunction
"}}}

" ---------------------------------------------------------------------------------------
" file
" ---------------------------------------------------------------------------------------
"{{{
set nobackup
set autoread
set noswapfile
set hidden

filetype indent on
filetype plugin on
"}}}

" ---------------------------------------------------------------------------------------
" etc
" ---------------------------------------------------------------------------------------
"{{{
set number
set history=50
set cmdheight=2
"}}}

