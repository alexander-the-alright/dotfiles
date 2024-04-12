" ====================================================================
" Auth: jontino
" Lang: ANO
" Revn: 04-17-2023  1.0
" Func: Define syntax coloring for .ano files when being edited in Vim
"
" TODO: begin writing, add new words
"       implement regular expressions for match baby names
" ====================================================================
" CHANGE LOG
" --------------------------------------------------------------------
" 04-17-2023: copied from prv.vim
"
" ====================================================================

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif


" Required fields
"   Comments
"       header comments         #           Green
"       single line comments    //          Cyan
"       in/multi line comments  /* ... */   Cyan
"   Quotes
"       must work multiline
"           Gray? LightRed?
"   Names
"



" XXX Dates:
" Date highlighting for the Change Log
" the first and last quote define the expression
" \d is any digit [0-9]
" \{1,2} matches 1 or 2 times, although it should only ever get 2
" - literal hyphen, which seperates months, days, and years
" The same three elements are repeated again for the days
" \d is any digit, used again for the years
" \{4} for only four digits can be matched
" ends with : because only dates in change log should be highlighted
" marked as contained, as it should only be highlighted in comments
" contains colon, so I can highlight the color separately
" for some reason, the colon doesn't work as keyword, so simple match
syn match date "\d\{1,2}-\d\{1,2}-\d\{4}:" contained contains=colon
syn match colon ":" contained



" XXX Comments:
" comments come after #
" eg| not comment  # now a comment
"     # comment
"     not a comment
"     not
"     not
"                     ### comment
"
" first and last quote define the expression
" # can come literally, because it doesn't need escaping
" . is every non-new line character possible
" * matches as many matches as possible
" i.e. a pound sign, and then as many characters as possible
syn match header "#.*" contains=commentFields,commentTodo,date,names,germ,rus,latin,rusgerm
syn match SLcomment "//.*" contains=names,germ,rus,latin,rusgerm
syn region ILMLcomment start="/\*" end="\*/" contains=names,germ,rus,latin,rusgerm
" commentFields and commentTodo are contained within comments, so they
" are as such in the definition of a comment, and listed as contained
" in their own definitions
" commentFields is match instead of keyword, will contain the space
syn keyword commentFields contained Auth Revn File Func
syn keyword commentTodo contained TODO todo Todo XXX FIXME
syn match commentFields contained "CHANGE LOG"



" XXX Quotes:
" quotes should exist between odd pairs of quotation marks
" eg| "quote" not
"     "quote" not "quote"
"     "not
"     quote"
"     "quote only if the it rolls
"     over onto the next line"
" Calling the quotation a region instead of pattern match makes it
" easier to wrap around a new line
" the first and last quote define the expression
" \ escapes the next character, allowing \" to appear as a literal "
" thus, start and end are both quotes, and the reqion can span lines
syn region quote start="\"" end="\"" contains=names,germ,rus,latin,rusgerm
"  -- DEPRECATED --
" the first and last quote define the expression
"  \ is the escape character, so \" means I want to look for a quote
"  . is every non-new line character possible
"  \{,} is \{0,infinity}, means I'm looking for between 0 and infinity
"       matches for the previous character, which is a wildcard, .
"  \{-,} will prioritize the smallest amount of matches possible
" syn match quote "\".\{-,}\""
"  -- DEPRECATED --



" XXX Notes:
" Allow for notes to be left with special highlighting
" \c escapes the case, so search is entirely case insensitive
" note are all literals
" s\? will alow for either 0 or 1 of the character "s" to be matched,
"       essentially allowing for both notes and note
" finally followed by a colon
" nextgroup is the actual notes to be taken, as this is just the tag
syn match noteTag "\cnotes\?:" nextgroup=notes
" define notes as starting with space, ending with exclamation mark
" if it's not denoted as contained, then the whole damn thing will be
"       highlighted
syn region notes start=" " end="!" contained



" XXX Names:
" keyword to the whole list of words
" lmfao ignore case sensitivity to avoid writing things twice
syn case ignore

" nicknames for archie
syn keyword ambiii  archie chicho chach chibo
syn keyword ambiii  barchie chachfield archibald
syn match ambiii    "Lord Archibald Mordecai Blackanddecker III"

" nicknames for olly
syn keyword obrg    olly bolly boliver oliver ogibler oboe
syn match obrg      "bolly bear"
syn match obrg      "bolly ball"
syn match obrg      "olly ball"
syn match obrg      "Sir Oliver Boliver Rockford Gubbins"

" things that apply to both babies
syn match both      "of Sealand"
syn match both      "sink boy"
syn match both      "baby boy"

" us?
syn keyword parents mom dad

syn case match
" lmfao and turn the case sensitivity back on




" keeping this as it might be useful later
" XXX Expressions:
" highlight equations, formulas, expressions, etc
" expressions: .* is any number of characters
"              = is literal
"              .* is any number of characters again
"              added spaces around = to avoid confusion with =>
"              
"              the idea is that it's stuff that equals stuff, and we
"              worry about what it is later
" name: \c case-escapes the sequence
"       \a is alphabetic characters, probably don't need escaping
"       \+ is at least 1 match, so it's 1 or more letters is a name
" name: \c\a\=  is 0 or 1 case-escaped alphabetic characters
"       _       is literal, best I can get to subscripts
"       \a\+    is 1 or more case-escaped alphabetic characters
" op: inside [] can allow for one choice from any contained characters
"     =, +, -, /, ^ are all literals for operations
"     \* escapes the * character, which is now multiplication
" Num: see Numbers: below
" FIXME try to make name into one thing, probably with \{,1}


" ColorGuide: ctermfg and ctermbg args - - - - source:: :help cterm
" Black
" LightBlue/Cyan/LightCyan, Blue/DarkBlue/DarkCyan
" Green/LightGreen, DarkGreen
" Red/LightRed, DarkRed
" Magenta/LightMagenta, DarkMagenta
" Yellow/LightYellow, DarkYellow/Brown
" White
" Gray/LightGray, DarkGray
" ColorGuide: ctermfg and ctermbg args - - - - source:: :help cterm
" ColorGuide: - - - - - - - - - - - - - - - source:: :help group-name
" Dates and fields in comments still use links for highlighting to get
" access to 'term' arguments that don't want to load correctly, namely
" Underline     -> PreProc (Magenta in default colo), with underline 
" ColorGuide: - - - - - - - - - - - - - - - source:: :help group-name


" XXX Coloring:
" hi[ghlight] <group> cterm=<style> ctermfg=<color> [ctermbg=<color>]
" group is typically a user-made group
" cterm is stuff like Underline and Bold
" ctermfg is the foreground, or font color
" ctermbg is the background color, or highlight color

" quotes are good
hi quote ctermfg=DarkRed

" header comments are good
hi header ctermfg=Green
" leaving these as link because I like the color it sets
" in theory... I could choose my own colors...
"hi def link commentFields Underlined
"hi def link date Underlined
hi commentFields cterm=Underline ctermfg=Blue
hi date cterm=Underline ctermfg=Blue

" comments are good
hi SLcomment ctermfg=Cyan
hi ILMLcomment ctermfg=Cyan
hi colon ctermfg=Cyan
hi commentTodo ctermfg=Black ctermbg=Yellow

" important notes
" could probably do without this, tbh
hi noteTag ctermfg=White ctermbg=Red
hi notes ctermfg=White ctermbg=Red

" nicknames for the boys
hi ambiii ctermfg=Green
hi obrg ctermfg=Red
" picked by archie himself
hi both ctermfg=LightBlue
hi parents ctermfg=DarkGray

let b:current_syntax = "ano"

