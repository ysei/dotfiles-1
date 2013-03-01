" Vim syntax file
" Language:	   DokuWiki
" Version:     0.1
" Maintainer:	 Bill Powell <bill@billpowellisalive.com> http://billpowellisalive.com
" Last Change: 2008 Sep 11, 12:53 Thu

"Based on Wikipedia.vim syntax file.  Still rather a hack.
"Please let me know if you find errors or make improvements.
"Do note the heading mappings below, though. Use 
"
"TODO Might have to tweak Wikimedia.vim because at the end it unlets main_syntax. Hmm.
"
"AUTOMATIC MATCHING {{{1

"At present, you have to activate this highlighting manually.
":se ft=dokuwiki

"because there isn't a canonical extension for DokuWiki
"files (at least, that I know of). However, you can set all
"*.txt files to automatically be set to DokuWiki if you
"wish.
"
"(Modified from http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim)

"Make or edit $HOME/.vim/ftdetect/txt.vim.
"And, without comments, add the following:
"
"augroup filetypedetect
	"au BufNewFile,BufRead *.txt,*.wiki setf dokuwiki
"augroup END

"}}}1
"
"==============================================
"And now, the syntax file:

syntax clear
" mediawiki.vim (formerly named Wikipedia.vim)
"
" Vim syntax file
" Language: MediaWiki, http://www.mediawiki.org/
" Maintainer: This syntax file needs a maintainer in order to ship
"     with Vim. Please contact [[User:Unforgettableid]] if you want
"     to volunteer.
" Home: http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim
" Last Change: 2011 Sep 19
" Credits: [[User:Aepd87]], [[User:Danny373]], [[User:Ingo Karkat]], et al.
"
" Published on Wikipedia in 2003-04 and declared authorless.
"
" Based on the HTML syntax file. Probably too closely based, in fact.
" There may well be name collisions everywhere, but ignorance is bliss,
" so they say.
"
" To do: plug-in support for downloading and uploading to the server.

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = "html"
endif

syntax case ignore
if v:version >= 700
  syntax spell toplevel
endif

" Mark illegal characters
sy match htmlError "[<>&]"

" Tags
sy region  htmlString   contained start=+"+                        end=+"+ contains=htmlSpecialChar,@htmlPreproc
sy region  htmlString   contained start=+'+                        end=+'+ contains=htmlSpecialChar,@htmlPreproc
sy match   htmlValue    contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1         contains=@htmlPreproc
sy region  htmlEndTag             start=+</+                       end=+>+ contains=htmlTagN,htmlTagError
sy region  htmlTag                start=+<[^/]+                    end=+>+ contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster
sy match   htmlTagN     contained +<\s*[-a-zA-Z0-9]\++hs=s+1               contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
sy match   htmlTagN     contained +</\s*[-a-zA-Z0-9]\++hs=s+2              contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
sy match   htmlTagError contained "[^>]<"ms=s+1

" Allowed HTML tag names
sy keyword htmlTagName contained big blockquote br caption center cite code
sy keyword htmlTagName contained dd del div dl dt font hr ins li
sy keyword htmlTagName contained ol p pre rb rp rt ruby s small span strike sub
sy keyword htmlTagName contained sup table td th tr tt ul var
sy match   htmlTagName contained "\<\(b\|i\|u\|h[1-6]\|em\|strong\)\>"
" Allowed Wiki tag names
sy keyword htmlTagName contained math nowiki references source syntaxhighlight

" Allowed arg names
sy keyword htmlArg contained align lang dir width height nowrap bgcolor clear
sy keyword htmlArg contained noshade cite datetime size face color type start
sy keyword htmlArg contained value compact summary border frame rules
sy keyword htmlArg contained cellspacing cellpadding valign char charoff
sy keyword htmlArg contained colgroup col span abbr axis headers scope rowspan
sy keyword htmlArg contained colspan id class name style title

" Special characters
sy match htmlSpecialChar "&#\=[0-9A-Za-z]\{1,8};"

" Comments
sy region htmlComment                start=+<!+                end=+>+     contains=htmlCommentPart,htmlCommentError
sy match  htmlCommentError contained "[^><!]"
sy region htmlCommentPart  contained start=+--+                end=+--\s*+ contains=@htmlPreProc
sy region htmlComment                start=+<!DOCTYPE+ keepend end=+>+

if !exists("html_no_rendering")
  sy cluster htmlTop contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,htmlLink,@htmlPreproc

  sy region htmlBold                          start="<b\>"      end="</b>"me=e-4      contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
  sy region htmlBold                          start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
  sy region htmlBoldUnderline       contained start="<u\>"      end="</u>"me=e-4      contains=@htmlTop,htmlBoldUnderlineItalic
  sy region htmlBoldItalic          contained start="<i\>"      end="</i>"me=e-4      contains=@htmlTop,htmlBoldItalicUnderline
  sy region htmlBoldItalic          contained start="<em\>"     end="</em>"me=e-5     contains=@htmlTop,htmlBoldItalicUnderline
  sy region htmlBoldUnderlineItalic contained start="<i\>"      end="</i>"me=e-4      contains=@htmlTop
  sy region htmlBoldUnderlineItalic contained start="<em\>"     end="</em>"me=e-5     contains=@htmlTop
  sy region htmlBoldItalicUnderline contained start="<u\>"      end="</u>"me=e-4      contains=@htmlTop,htmlBoldUnderlineItalic

  sy region htmlUnderline                     start="<u\>"      end="</u>"me=e-4      contains=@htmlTop,htmlUnderlineBold,htmlUnderlineItalic
  sy region htmlUnderlineBold       contained start="<b\>"      end="</b>"me=e-4      contains=@htmlTop,htmlUnderlineBoldItalic
  sy region htmlUnderlineBold       contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlUnderlineBoldItalic
  sy region htmlUnderlineItalic     contained start="<i\>"      end="</i>"me=e-4      contains=@htmlTop,htmlUnderlineItalicBold
  sy region htmlUnderlineItalic     contained start="<em\>"     end="</em>"me=e-5     contains=@htmlTop,htmlUnderlineItalicBold
  sy region htmlUnderlineItalicBold contained start="<b\>"      end="</b>"me=e-4      contains=@htmlTop
  sy region htmlUnderlineItalicBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop
  sy region htmlUnderlineBoldItalic contained start="<i\>"      end="</i>"me=e-4      contains=@htmlTop
  sy region htmlUnderlineBoldItalic contained start="<em\>"     end="</em>"me=e-5     contains=@htmlTop

  sy region htmlItalic                        start="<i\>"      end="</i>"me=e-4      contains=@htmlTop,htmlItalicBold,htmlItalicUnderline
  sy region htmlItalic                        start="<em\>"     end="</em>"me=e-5     contains=@htmlTop
  sy region htmlItalicBold          contained start="<b\>"      end="</b>"me=e-4      contains=@htmlTop,htmlItalicBoldUnderline
  sy region htmlItalicBold          contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlItalicBoldUnderline
  sy region htmlItalicBoldUnderline contained start="<u\>"      end="</u>"me=e-4      contains=@htmlTop
  sy region htmlItalicUnderline     contained start="<u\>"      end="</u>"me=e-4      contains=@htmlTop,htmlItalicUnderlineBold
  sy region htmlItalicUnderlineBold contained start="<b\>"      end="</b>"me=e-4      contains=@htmlTop
  sy region htmlItalicUnderlineBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop

  sy region htmlH1    start="<h1\>"    end="</h1>"me=e-5    contains=@htmlTop
  sy region htmlH2    start="<h2\>"    end="</h2>"me=e-5    contains=@htmlTop
  sy region htmlH3    start="<h3\>"    end="</h3>"me=e-5    contains=@htmlTop
  sy region htmlH4    start="<h4\>"    end="</h4>"me=e-5    contains=@htmlTop
  sy region htmlH5    start="<h5\>"    end="</h5>"me=e-5    contains=@htmlTop
  sy region htmlH6    start="<h6\>"    end="</h6>"me=e-5    contains=@htmlTop
endif


" No htmlTop and wikiPre inside HTML preformatted areas, because
" MediaWiki renders everything in there literally (HTML tags and
" entities, too): <pre> tags work as the combination of <nowiki> and
" the standard HTML <pre> tag: the content will preformatted, and it
" will not be parsed, but shown as in the wikitext source.
"
" With wikiPre, indented lines would be rendered differently from
" unindented lines.
sy match htmlPreTag       /<pre>/         contains=htmlTag
sy match htmlPreEndTag    /<\/pre>/       contains=htmlEndTag
sy match wikiNowikiTag    /<nowiki>/      contains=htmlTag
sy match wikiNowikiEndTag /<\/nowiki>/    contains=htmlEndTag
sy match wikiSourceTag    /<source\s\+[^>]\+>/ contains=htmlTag
sy match wikiSourceEndTag /<\/source>/    contains=htmlEndTag
sy match wikiSyntaxHLTag    /<syntaxhighlight\s\+[^>]\+>/ contains=htmlTag
sy match wikiSyntaxHLEndTag /<\/syntaxhighlight>/    contains=htmlEndTag

" Note: Cannot use 'start="<pre>"rs=e', so still have the <pre> tag
" highlighted correctly via separate sy-match. Unfortunately, this will
" also highlight <pre> tags inside the preformatted region.
sy region htmlPre    start="<pre>"                 end="<\/pre>"me=e-6    contains=htmlPreTag
sy region wikiNowiki start="<nowiki>"              end="<\/nowiki>"me=e-9 contains=wikiNowikiTag
sy region wikiSource start="<source\s\+[^>]\+>"         keepend end="<\/source>"me=e-9 contains=wikiSourceTag
sy region wikiSyntaxHL start="<syntaxhighlight\s\+[^>]\+>" keepend end="<\/syntaxhighlight>"me=e-18 contains=wikiSyntaxHLTag

sy include @TeX syntax/tex.vim
sy region wikiTeX matchgroup=htmlTag start="<math>" end="<\/math>"  contains=@texMathZoneGroup,wikiNowiki,wikiNowikiEndTag
sy region wikiRef matchgroup=htmlTag start="<ref>"  end="<\/ref>"   contains=wikiNowiki,wikiNowikiEndTag

sy cluster wikiTop contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag

sy region wikiItalic        start=+'\@<!'''\@!+ end=+''+    oneline contains=@wikiTop,wikiItalicBold
sy region wikiBold          start=+'''+         end=+'''+   oneline contains=@wikiTop,wikiBoldItalic
sy region wikiBoldAndItalic start=+'''''+       end=+'''''+ oneline contains=@wikiTop

sy region wikiBoldItalic contained start=+'\@<!'''\@!+ end=+''+  oneline contains=@wikiTop
sy region wikiItalicBold contained start=+'''+         end=+'''+ oneline contains=@wikiTop

sy region wikiH1 start="^="      end="="      oneline contains=@wikiTop
sy region wikiH2 start="^=="     end="=="     oneline contains=@wikiTop
sy region wikiH3 start="^==="    end="==="    oneline contains=@wikiTop
sy region wikiH4 start="^===="   end="===="   oneline contains=@wikiTop
sy region wikiH5 start="^====="  end="====="  oneline contains=@wikiTop
sy region wikiH6 start="^======" end="======" oneline contains=@wikiTop

sy region wikiLink start="\[\[" end="\]\]\(s\|'s\|es\|ing\|\)" oneline contains=wikiLink,wikiNowiki,wikiNowikiEndTag

sy region wikiLink start="\[http:"   end="\]" oneline contains=wikiNowiki,wikiNowikiEndTag
sy region wikiLink start="\[https:"  end="\]" oneline contains=wikiNowiki,wikiNowikiEndTag
sy region wikiLink start="\[ftp:"    end="\]" oneline contains=wikiNowiki,wikiNowikiEndTag
sy region wikiLink start="\[gopher:" end="\]" oneline contains=wikiNowiki,wikiNowikiEndTag
sy region wikiLink start="\[news:"   end="\]" oneline contains=wikiNowiki,wikiNowikiEndTag
sy region wikiLink start="\[mailto:" end="\]" oneline contains=wikiNowiki,wikiNowikiEndTag

sy region wikiTemplate start="{{" end="}}" contains=wikiNowiki,wikiNowikiEndTag

sy match wikiParaFormatChar /^[\:|\*|;|#]\+/
sy match wikiParaFormatChar /^-----*/
sy match wikiPre            /^\ .*$/         contains=wikiNowiki,wikiNowikiEndTag


" HTML highlighting

if version < 508
  command! -nargs=+ HtmlHiLink hi link     <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

if version >= 508 || !exists("did_html_syn_inits")
  HtmlHiLink htmlTag            Function
  HtmlHiLink htmlEndTag         Identifier
  HtmlHiLink htmlArg            Type
  HtmlHiLink htmlTagName        htmlStatement
  HtmlHiLink htmlSpecialTagName Exception
  HtmlHiLink htmlValue          String
  HtmlHiLink htmlSpecialChar    Special

  if !exists("html_no_rendering")
    HtmlHiLink htmlTitle Title
    HtmlHiLink htmlH1    htmlTitle
    HtmlHiLink htmlH2    htmlTitle
    HtmlHiLink htmlH3    htmlTitle
    HtmlHiLink htmlH4    htmlTitle
    HtmlHiLink htmlH5    htmlTitle
    HtmlHiLink htmlH6    htmlTitle

    HtmlHiLink htmlPreProc          PreProc
    HtmlHiLink htmlHead             htmlPreProc
    HtmlHiLink htmlPreProcAttrName  htmlPreProc
    HtmlHiLink htmlPreStmt          htmlPreProc

    HtmlHiLink htmlSpecial          Special
    HtmlHiLink htmlCssDefinition    htmlSpecial
    HtmlHiLink htmlEvent            htmlSpecial
    HtmlHiLink htmlSpecialChar      htmlSpecial

    HtmlHiLink htmlComment          Comment
    HtmlHiLink htmlCommentPart      htmlComment
    HtmlHiLink htmlCssStyleComment  htmlComment

    HtmlHiLink htmlString           String
    HtmlHiLink htmlPreAttr          htmlString
    HtmlHiLink htmlValue            htmlString

    HtmlHiLink htmlError            Error
    HtmlHiLink htmlBadArg           htmlError
    HtmlHiLink htmlBadTag           htmlError
    HtmlHiLink htmlCommentError     htmlError
    HtmlHiLink htmlPreError         htmlError
    HtmlHiLink htmlPreProcAttrError htmlError
    HtmlHiLink htmlTagError         htmlError

    HtmlHiLink htmlStatement        Statement

    HtmlHiLink htmlConstant         Constant

    HtmlHiLink htmlBoldItalicUnderline htmlBoldUnderlineItalic
    HtmlHiLink htmlUnderlineItalicBold htmlBoldUnderlineItalic
    HtmlHiLink htmlUnderlineBoldItalic htmlBoldUnderlineItalic
    HtmlHiLink htmlItalicBoldUnderline htmlBoldUnderlineItalic
    HtmlHiLink htmlItalicUnderlineBold htmlBoldUnderlineItalic

    HtmlHiLink htmlItalicBold          htmlBoldItalic
    HtmlHiLink htmlItalicUnderline     htmlUnderlineItalic
    HtmlHiLink htmlUnderlineBold       htmlBoldUnderline

    HtmlHiLink htmlLink Underlined

    if !exists("html_my_rendering")
      hi def htmlBold                term=bold                  cterm=bold                  gui=bold
      hi def htmlBoldUnderline       term=bold,underline        cterm=bold,underline        gui=bold,underline
      hi def htmlBoldItalic          term=bold,italic           cterm=bold,italic           gui=bold,italic
      hi def htmlBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
      hi def htmlUnderline           term=underline             cterm=underline             gui=underline
      hi def htmlUnderlineItalic     term=italic,underline      cterm=italic,underline      gui=italic,underline
      hi def htmlItalic              term=italic                cterm=italic                gui=italic
    endif

  endif " !exists("html_no_rendering")

  if version < 508
    let did_html_syn_inits = 1
  endif

endif " version >= 508 || !exists("did_html_syn_inits")

" Wiki highlighting

HtmlHiLink wikiItalic        htmlItalic
HtmlHiLink wikiBold          htmlBold
HtmlHiLink wikiBoldItalic    htmlBoldItalic
HtmlHiLink wikiItalicBold    htmlBoldItalic
HtmlHiLink wikiBoldAndItalic htmlBoldItalic

HtmlHiLink wikiH1 htmlTitle
HtmlHiLink wikiH2 htmlTitle
HtmlHiLink wikiH3 htmlTitle
HtmlHiLink wikiH4 htmlTitle
HtmlHiLink wikiH5 htmlTitle
HtmlHiLink wikiH6 htmlTitle

HtmlHiLink wikiLink           htmlLink
HtmlHiLink wikiTemplate       htmlSpecial
HtmlHiLink wikiParaFormatChar htmlSpecial
HtmlHiLink wikiPre            htmlConstant
HtmlHiLink wikiRef            htmlComment

HtmlHiLink wikiSource         wikiPre
HtmlHiLink wikiSyntaxHL       wikiPre


let b:current_syntax = "html"

delcommand HtmlHiLink

if main_syntax == "html"
  unlet main_syntax
endif

" vim: set et sts=2 sw=2:


"Mappings {{{1
"
"This should allow you to press ",,h1" in INSERT mode, then
"type your header, then press <C-j> to jump to the next
"line.  
"
"(If <C-j> doesn't jump for you, let me know; this
"may require latex-suite (http://vim-latex.sf.net), but that
"would be a hefty thing to download just for this.)
"
"Darn huge DokuWiki headings:
imap <buffer> ,,h1 ====== <++> ======<++><Esc>k0<C-J>
imap <buffer> ,,h2 ===== <++> =====<++><Esc>k0<C-J>
imap <buffer> ,,h3 ==== <++> ====<++><Esc>k0<C-J>
imap <buffer> ,,h4 === <++> ===<++><Esc>k0<C-J>
imap <buffer> ,,h5 == <++> ==<++><Esc>k0<C-J>
imap <buffer> ,,h6 = <++> =<++><Esc>k0<C-J>

"promote and demote
imap <buffer> ,,hd <Esc>:s#=\(.*\)=#\1#<CR>:let @/ = ""<CR>
nmap <buffer> ,,hd :s#=\(.*\)=#\1#<CR>:let @/ = ""<CR>
imap <buffer> ,,hp <Esc>:s#\(.*\)#=\1=#<CR>:let @/ = ""<CR>
nmap <buffer> ,,hp :s#\(.*\)#=\1=#<CR>:let @/ = ""<CR>

"}}}1


"From Wikipedia.vim
"Need this function for html.
"
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif
let main_syntax = 'html'


"==============================================

"Need to clear wikiLink, start over.
syn clear wikiLink 
"Note you don't want to match on \\ if it's http:\\
"Fortunately, a judicious match of wikiLink trumps wikiItalic.
syn region wikiLink start="\[\[" end="\]\]\(s\|'s\|es\|ing\|\)" contains=wikiLink,wikiTemplate
"Special match for links not in brackets.
syn region wikiHttp start=+\(\(http\|https\|ftp\|gopher\|news\|mailto\):\/\/\|www\.\)+ end=+ +me=e-1

syn match wikiEmail /<[a-zA-Z_.0-9-]*@[a-zA-Z_.0-9-]*>/
syn region wikiItalic			start=+\/\/+	end=+\/\/+ contains=@Spell,wikiLink,wikiItalicBold
syn region wikiBold				start=+\*\*+			end=+\*\*+ contains=@Spell,wikiLink,wikiBoldItalic
syn region wikiBoldAndItalic	start=+'''''+		end=+'''''+ contains=@Spell,wikiLink

"TODO Make combinations work. Maybe.

syn region wikiUnderline			start=+__+	end=+__+ contains=@Spell,wikiLink
syn match wikiLinebreak /\\\\/ 

"Wikipedia italic is Dokuwiki mono. Hmm.
syn region wikiMono			start=+'\@<!'''\@!+	end=+''+ contains=@Spell
syn region wikiDel			start=+<del>+	end=+</del>+ contains=@Spell


"syn clear wikiParaFormatChar

"Too many emoticons.
syn match wikiKeyword /\(8-)\|8-O\|:-(\|:-)\|=)\|:-\/\|:-\\\\\|:-?\|:-D\|:-P\|:-O\|:-X\|:-|\|;-)\|\^_\^\|:?:\|:!:\|LOL\|FIXME\|DELETEME\)/
"TODO Get the broken ones to work. :)
"Typeset characters
syn match wikiKeyword /\(->\|<\(-\|=\)\(>\)\=\|=>\|<=\|>>\|<<\|--\(-\)\=\|640x480\|(c)\|(tm)\|(r)\)/
"TODO Brackets
"syn match wikiKeyword /\[\[\|\]\]\|{{\|}}/ containedin=wikiLink

"Lists
syn match wikiKeyword /^\(\s\s\)*[*-] / containedin=wikiPre

syn region wikiNowiki start=+%%+ end=+%%+
syn region wikiNowiki start=+<nowiki>+ end=+</nowiki>+

"TODO : Fix <code> hack, which doesn't really keep all code snippets
"clean.
syn region wikiCode start=+<\(file\|code\)+ms=s+5 end=+</\(file\|code\)>+me=e-7 contains=@Spell 
"Dangerous things in the dang code block.
"TODO figure out how to not have to match these individually.
"C comments: eternal bold
syn match wikiKeyword /\/\*\*/ 

syn region wikiFootnote start=+((+ end=+))+
syn region wikiInstruction start=+\~\~+ end=+\~\~+

syn match wikiQ1 /^\s*>.*/ containedin=wikiPre
syn match wikiQ2 /^\s*>>.*/ containedin=wikiPre
syn match wikiQ3 /^\s*>>>.*/ containedin=wikiPre
syn match wikiQ4 /^\s*>>>>.*/ containedin=wikiPre
"Four is quite enough, young man.

"Dokuwiki headings are the reverse of Wikipedia headings: H1 is
"====== H1 ======, not = H1 =. 
"It looks cooler, but you need a mapping for hi-level headings!
syn region wikiH6 start="^=" 		end="=" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink
syn region wikiH5 start="^==" 		end="==" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink
syn region wikiH4 start="^===" 		end="===" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink
syn region wikiH3 start="^====" 	end="====" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink
syn region wikiH2 start="^=====" 	end="=====" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink
syn region wikiH1 start="^======" 	end="======" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink



"Special tags: probably only work with div-shorthand plugin by Joe Lapp.
"See http://wiki.splitbrain.org/plugin:div_span_shorthand
"I'm using the modified version at the bottom of the page.
"Allows you to insert div tags when you need them without needing 
"to allow html.

"Blockquote and Cite. 
"To use these, you'll have to use a strict syntax.
"
"#blockquote[
"Your quote can be as many lines as you want.
"But when you're done, the final tag must be on its own line.
"This is so you can have an option citation:
"#cite[Kenneth Grahame, //Wind in the Willows//]#
"]#
"
"If the final tag isn't on its own line, it won't work.
"
"Also note that this is div.blockquote and div.cite, NOT the html tags
"<blockquote> and <cite>. You'll want to keep that in mind for your
"css file. :)
"
"If DokuWiki didn't insert <BR>'s after each line in a blockquote, you
"wouldn't need this silliness.
"
syn match wikiKeyword /#\(blockquote\|cite\)\[/ containedin=wikiBlockquote
"TODO: Get ending bracket to match without breaking Blockquote
"environment.
"syn match wikiKeyword /\]#/ containedin=wikiBlockquote,wikiCite
syn region wikiBlockquote start=+^#blockquote\[+ 	end=+^\]#+ contains=@Spell,wikiLink,wikiCite,wikiParaFormatChar
syn region wikiCite start=+^#cite\[+ 	end=+\]#+ oneline contains=@Spell,wikiLink,wikiKeyword

"Comments: requires 'comments' plugin by Esther Bruner.
syn clear htmlCommentError
"TODO Get to work for multi-line comments.
syn region wikiComment start=+\/\*+	end=+\*\/+ contains=wikiPre

"COLORS not covered in Wikipedia.vim

hi link wikiHttp	wikiLink
hi link wikiEmail	wikiLink
hi link wikiUnderline	htmlUnderline
"NOTE : Ignore is occasionally invisible, depending on your scheme.
hi link wikiNowiki	Ignore
hi link wikiCode wikiPre
hi link wikiInstruction Exception
hi link wikiMono	Todo
hi link wikiDel	Error
hi link wikiLinebreak	Keyword
hi link wikiKeyword	Keyword
hi link wikiBlockquote Type
hi link wikiComment Comment
"Perhaps it's confusing to have anything besides Comments be
"highlighted as comments. But I figure comments in wikis will be quite
"rare. You may disagree.
hi link wikiFootnote Comment
hi link wikiCite Comment

"The quote levels will tend to intersect with the headings,
"depending on color scheme. Ah well.
"If you go to syntax.txt and look at the NAMING CONVENTIONS, you'll
"see I tried to choose groups here that'd match up with lower-level
"headings, to avoid confusion whenever possible. Basically, work my
"way back UP the ladder with quotes.
hi link wikiQ1 StorageClass
hi link wikiQ2 Conditional
hi link wikiQ3 Include
hi link wikiQ4 String

"Colors I relinked.
hi link wikiPre Special

"Why not give each heading a different color?
hi link htmlH1	Title 
hi link htmlH2	Identifier
hi link htmlH3	Constant
hi link htmlH4	PreProc   
hi link htmlH5	Statement 
hi link htmlH6	Type



"Tables need to come after this, for some reason.
"Tables
syn match wikiKeyword /[|\^]/ containedin=wikiPre,wikiTableCell,wikiTableHeading
syn match wikiTableCell /\s*|.*/ containedin=wikiPre
syn match wikiTableHeading /\s*\^.*/ containedin=wikiPre


hi link wikiTableCell PreCondit
hi link wikiTableHeading Character

" CLOSE DOWN, from Wikipedia.vim
let b:current_syntax = "html"

delcommand HtmlHiLink

if main_syntax == 'html'
  unlet main_syntax
endif
