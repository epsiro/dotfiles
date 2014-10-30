set termencoding=utf8
set fileencoding=utf8
set encoding=utf8

filetype indent plugin on

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set autoindent
set autowrite
set background=dark
set backspace=indent,eol,start
set cinoptions=:0
set expandtab
set hidden
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
set modelines=2
set mouse=
set noerrorbells
set nofoldenable
set hlsearch
set pastetoggle=<F2>
set ruler
set shiftwidth=4
set shortmess+=I
set smartcase
set softtabstop=4
set statusline=%F\ %m%r%h%w[%{&fenc},%{&bomb}][%{&ff}]%y\ line:%l/%L\ col:%c%V
set tabstop=4
set textwidth=79
set wildmenu

" Treat _ as word boundary
"set iskeyword-=_

if v:version >= 703
    set undodir=~/.vimundo
    set undofile
    set undolevels=10000
    set undoreload=100000
endif

syntax on

function! FixHTMLChar()
    silent! %s/æ/\&aelig\;/g
    silent! %s/ø/\&oslash\;/g
    silent! %s/å/\&aring\;/g
    silent! %s/Æ/\&Aelig\;/g
    silent! %s/Ø/\&Oslash\;/g
    silent! %s/Å/\&Aring\;/g
    silent! call FixInvisiblePunctuation()
endfunction

function! FixInvisiblePunctuation()
    silent! %s/\%u2018/'/g
    silent! %s/\%u2019/'/g
    silent! %s/\%u2026/.../g
    silent! %s/\%uf0e0/->/g
    silent! %s/\%u0092/'/g
    silent! %s/\%u2013/-/g
    silent! %s/\%u2014/-/g
    silent! %s/\%u201C/"/g
    silent! %s/\%u201D/"/g
    silent! %s/\%u0052\%u20ac\%u2122/'/g
    silent! %s/\%ua0/ /g
    retab
endfunction


map <silent> K :Man <cword><CR>
runtime ftplugin/man.vim

let @u = "i$\\unit[f s]{ea}$"
let @v = "i\\unit[f s]{ea}"

let @n = "i\\newterm{ea}"

let @m = "i$ea$"

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>

" Latex macro
" unit
"
"let @c = "i^M^[t a^M^[kIscale=3; ^[A/254^[V!bc^M^[kJJimm^["
let @c = "it akIscale=3; A*2.54/10000V!bckJJimm"
