set nocompatible

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set fileencodings=utf-8,latin1
endif

"set encoding=utf-8
scriptencoding utf-8

call pathogen#infect()

filetype indent off
filetype plugin indent off

set hidden
set nowrap
set bs=2              " allow backspacing over everything in insert mode
set noai
set nobackup
set title
set viminfo='20,\"50  " read/write a .viminfo file, don't store more
                      " than 50 lines of registers
set history=50        " keep 50 lines of command line history
set ruler             " show the cursor position all the time
set mouse=a
set laststatus=2
set wildmenu

" set textwidth=72
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

setlocal comments-=:#

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

let g:sql_type_default = 'sqlanywhere'
let html_use_css = 1
" let html_number_lines = 0
let html_no_pre = 1

syntax on
set hlsearch

" let perl_want_scope_in_variables=1
let perl_extended_vars=1
" let perl_include_pod=1

"colorscheme molokai
colorscheme vividchalk

set guioptions-=r
set guioptions-=L
set guioptions-=T

if has("gui_running")
	set bg=dark
        set lines=50
        set columns=100
        colorscheme wuye

	if has("unix")
		set guifont=Monospace\ 10
	else
                set encoding=utf8
		set guifont=Lucida_Console:h10:cDEFAULT
		set guifont=Consolas:h10:cDEFAULT
		set guifont=DejaVu_Sans_Mono:h11:cDEFAULT
		let skip_loading_mswin=1
		set clipboard=unnamed
	endif
endif

if &diff
   set bg=dark
endif

if has("unix")
	set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
	set directory=~/tmp//,/var/tmp//,/tmp//
else
	set directory=$TEMP,.
endif

" Only do this part when compiled with support for autocommands
if has("autocmd")
	filetype on

"	autocmd BufWritePre *.py,*.js,*.css,*.html :call <SID>StripTrailingWhitespaces()
"	au BufNewFile,BufRead *.tt,*.tt2 setf html

	" In text files, always limit the width of text to 78 characters
	autocmd BufRead *.txt set tw=78

	" When editing a file, always jump to the last cursor position
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line ("'\"") <= line("$") |
		\   exe "normal! g'\"" |
		\ endif
endif

" Turn off syntax highlighting if file larger than 2MB
autocmd BufReadPre * if getfsize(expand("%")) > 2000000 | syntax off | endif

if &term=="xterm"
	set t_Co=8
	set t_Sb=[4%dm
	set t_Sf=[3%dm
endif

" if has("multi_byte") && !has("win32") && version >= 700
if &listchars ==# 'eol:$'
  set listchars=tab:>-,eol:$
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u25b8\u2015,eol:\u00ac"
  endif
endif

set matchpairs+=<:>

nmap <Leader>, :s/,\(\S\)/, \1/ge<CR>j
vmap <Leader>, :s/,\(\S\)/, \1/ge<CR>
vmap <Leader>t :Tab/
nmap <Leader>t :Tab/
vmap <Leader>= :Tab/=<CR>
nmap <Leader>= :Tab/=<CR>
vmap <Leader>> :Tab/=><CR>
nmap <Leader>> :Tab/=><CR>
nmap <Leader>p :0r ~/.perlstub.pl<CR>

" inoremap <Tab> <c-r>=Smart_TabComplete()<CR>

" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$
nnoremap <silent> <F6> :call <SID>StripTrailingWhitespaces()<CR>

" Wraps visual selection in an HTML tag
vmap ,w <ESC>:call VisualHTMLTagWrap()<CR>

map <Leader>r Oi....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8j0

cmap ;\ \(\)<Left><Left>
cmap w!! %!sudo tee > /dev/null %

highlight Search     term=reverse ctermbg=blue     ctermfg=white
highlight MatchParen              ctermbg=green    ctermfg=black
highlight SpecialKey              ctermfg=darkgrey
highlight NonText                 ctermfg=darkgrey
highlight MatchParen NONE
highlight MatchParen term=inverse cterm=inverse gui=inverse

cabbrev quoteattribs s/\v(id\|style\|name\|bgcolor\|type\|cellspacing\|colspan\|class\|cellpadding\|value\|tabindex\|border\|width\|align\|height\|wrap\|rows\|cols\|maxlength\|size)\=('?)([#$]?\w+\%?)(\2)/\1="\3"/gc

map <F2>  m'A<C-R>=strftime('%Y-%m-%d')<CR><Esc>``
map <F4>  :set list!<CR>
map <F5>  :set cul!<CR>:set cuc!<CR>
map <F7>  :bp<CR>
map <F8>  :bn<CR>
map <F11> :syn sync fromstart<CR>
map <F12> :nohlsearch<CR>

map Ol <C-W>+
map OS <C-W>-
map OQ <C-W><
map OR <C-W>>

"""""""" perl stub
""p  CHAR    0
"    :0r ~/.perl^M:14^Mi

" Settings for editing perl source (plus bind the above two functions)
function! MyPerlSettings()
	if !did_filetype()
		set filetype=perl
	endif

        set cms=#\ %s

"	syn include @Sql /usr/share/vim/vim71/syntax/sql.vim
"	syn include @Sql <sfile>:p:h/sql.vim
"	syn region perlSQL start="<<EOSQL" end="^EOSQL" contains=@Sql keepend

"	set formatoptions=croql
	set keywordprg=perldoc\ -f
endfunction

if has("eval")
	augroup SetEditOpts
		au!
		autocmd FileType perl :call MyPerlSettings()
	augroup END
endif

function! <SID>StripTrailingWhitespaces()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

" Wraps visual selection in an HTML tag
function! VisualHTMLTagWrap()
  let a:tag = input( "Tag to wrap block: ")
  let a:jumpright = 2 + len( a:tag )
  normal `<
  let a:init_line = line( "." )
  exe "normal i<".a:tag.">"
  normal `>
  let a:end_line = line( "." )
  " Don't jump if we're on a new line
  if( a:init_line == a:end_line )
    " Jump right to compensate for the characters we've added
    exe "normal ".a:jumpright."l"
  endif
  exe "normal a</".a:tag.">"
endfunction

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

