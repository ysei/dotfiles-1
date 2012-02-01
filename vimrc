if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set fileencodings=utf-8,latin1
endif

call pathogen#infect()

filetype indent off
filetype plugin indent off

set hidden
set nowrap
set nocompatible      " Use Vim defaults (much better!)
set bs=2              " allow backspacing over everything in insert mode
set noai
set nobackup
setlocal comments-=:#
set viminfo='20,\"50  " read/write a .viminfo file, don't store more
                      " than 50 lines of registers
set history=50        " keep 50 lines of command line history
set ruler             " show the cursor position all the time
set mouse=a

" set textwidth=72
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

syntax on
set hlsearch

let perl_extended_vars=1

if has("gui_running")
	set guioptions-=T
	colorscheme darkblue
	set bg=dark
	if has("unix")
		set guifont=Monospace\ 10
	else
		set guifont=Lucida_Console:h11:cDEFAULT
		let skip_loading_mswin=1
		set clipboard=unnamed
	endif
endif

if &diff
   set bg=dark
endif

if has("unix")
	set directory=~/tmp//,/var/tmp//,/tmp//
else
	set directory=.,$TEMP
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

if has("multi_byte") && !has("win32")
"	set listchars=tab:âºâ,eol:¬
 " wtf jim? fix this.
	set listchars=tab:▸―,eol:¬
"	set listchars=tab:>-,eol:$
else
	set listchars=tab:>-,eol:$
endif

set title
set matchpairs+=<:>

map <Leader>, :s/,\(\S\)/, \1/ge<CR>j

nnoremap <silent> <F6> :call <SID>StripTrailingWhitespaces()<CR>

" Wraps visual selection in an HTML tag
vmap ,w <ESC>:call VisualHTMLTagWrap()<CR>

map <Leader>r Oi....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8j0

cmap ;\ \(\)<Left><Left>

highlight Search     term=reverse ctermbg=blue     ctermfg=white
highlight MatchParen              ctermbg=green    ctermfg=black
highlight SpecialKey              ctermfg=darkgrey
highlight NonText                 ctermfg=darkgrey

cabbrev quoteattribs s/\v(id\|style\|name\|bgcolor\|type\|cellspacing\|colspan\|class\|cellpadding\|value\|tabindex\|border\|width\|align\|height\|wrap\|rows\|cols\|maxlength\|size)\=('?)([#$]?\w+\%?)(\2)/\1="\3"/gc

map <F2>  m'A<C-R>=strftime('%Y-%m-%d')<CR><Esc>``
map <F4>  :set list!<CR>
map <F5>  :set cul!<CR>:set cuc!<CR>
map <F7>  :tabp<CR>
map <F8>  :tabn<CR>
map <F11> :syn sync fromstart<CR>
map <F12> :let @/ = ""<CR>

map Ol <C-W>+
map OS <C-W>-
map OQ <C-W><
map OR <C-W>>

"""""""" perl stub
""p  CHAR    0
"    :0r ~/.perl^M:14^Mi

" perl -cw buffer, using a temp file, into a new window
function! PerlCW()
	let l:tmpfile1 = tempname()
	let l:tmpfile2 = tempname()

	execute "normal:w!" . l:tmpfile1 . "\<CR>"
	execute "normal:! perl -cw " . l:tmpfile1 . " \> " . l:tmpfile2 . " 2\>\&1 \<CR>"
	execute "normal:new\<CR>"
	execute "normal:edit " . l:tmpfile2 . "\<CR>"
endfunction

" perl buffer, using a temp file, into a new window
function! PerlOutput()
	let l:tmpfile1 = tempname()
	let l:tmpfile2 = tempname()

	execute "normal:w!" . l:tmpfile1 . "\<CR>"
	execute "normal:! perl " . l:tmpfile1 . " \> " . l:tmpfile2 . " 2\>\&1 \<CR>"
	execute "normal:new\<CR>"
	execute "normal:edit " . l:tmpfile2 . "\<CR>"
endfunction

" Settings for editing perl source (plus bind the above two functions)
function! MyPerlSettings()
	if !did_filetype()
		set filetype=perl
	endif

"	syn include @Sql /usr/share/vim/vim71/syntax/sql.vim
"	syn include @Sql <sfile>:p:h/sql.vim
"	syn region perlSQL start="<<EOSQL" end="^EOSQL" contains=@Sql keepend

"	set formatoptions=croql
	set keywordprg=perldoc\ -f

	noremap <f1> <Esc>:call PerlCW()<CR><Esc>
	noremap <f3> <Esc>:call PerlOutput()<CR><Esc>
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

