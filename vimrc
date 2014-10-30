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

nnoremap gi "ey:call CalcBC()<CR>
function! CalcBC()
  exec "normal a hei"
  "let has_equal = 0
  "" remove newlines and trailing spaces
  "let @e = substitute (@e, "\n", "", "g")
  "let @e = substitute (@e, '\s*$', "", "g")
  "" if we end with an equal, strip, and remember for output
  "if @e =~ "=$"
  "  let @e = substitute (@e, '=$', "", "")
  "  let has_equal = 1
  "endif
  "" sub common func names for bc equivalent
  "let @e = substitute (@e, '\csin\s*(', "s (", "")
  "let @e = substitute (@e, '\ccos\s*(', "c (", "")
  "let @e = substitute (@e, '\catan\s*(', "a (", "")
  "let @e = substitute (@e, "\cln\s*(", "l (", "")
  "" escape chars for shell
  "let @e = escape (@e, '*()')
  "" run bc, strip newline
  "let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")
  "" append answer or echo
  "if has_equal == 1
  "  normal `>
  "  exec "normal a" . answer
  "else
  "  echo "answer = " . answer
  "endif
endfunction


"function MyCalc(str)
"  if exists("g:MyCalcRounding")
"    return system("echo 'x=" . a:str . ";d=.5/10^" . g:MyCalcPresition
"          \. ";if (x<0) d=-d; x+=d; scale=" . g:MyCalcPresition . ";print x/1' | bc -l")
"  else
"    return system("echo 'scale=" . g:MyCalcPresition . " ; print " . a:str . "' | bc -l")
"  endif
"endfunction
"
"" Control the precision with this variable
"let g:MyCalcPresition = 2
"" Comment this if you don't want rounding
"let g:MyCalcRounding = 1
"" Use \C to replace the current line of math expression(s) by the value of the computation:
"map <silent> <Leader>c :s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
"" Same for a visual selection block
"vmap <silent> <Leader>c :B s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
"" With \C= don't replace, but add the result at the end of the current line
"map <silent> <Leader>c= :s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
"" Same for a visual selection block
"vmap <silent> <Leader>c= :B s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
"" Try: :B s/.*/\=MyCalc("1000 - " . submatch(0))/
"" The concatenation is important, since otherwise it will try
"" to evaluate things like in ":echo 1000 - ' 1748.24'"
"vmap <Leader>c+ :B s/.*/\=MyCalc(' +' . submatch(0))/<C-Left><C-Left><C-Left><Left>
"vmap <Leader>c- :B s/.*/\=MyCalc(' -' . submatch(0))/<C-Left><C-Left><C-Left><Left>
"" With \Cs you add a block of expressions, whose result appears in the command line
"vmap <silent> <Leader>ct y:echo MyCalc(substitute(@0," *\n","+","g"))<CR>:silent :noh<CR>
"" Try: :MyCalc 12.7 + sqrt(98)
"command! -nargs=+ MyCalc :echo MyCalc("<args>")
