" ====================================================================
" Auth: Alex Celani
" File: .vimrc
" Revn: 04-17-2023  2.0
" Func: Define how Vim works, set parameters, define keymaps
"
" TODO: add in Greek keymaps
"       make goddamn numpad work on terminal/in vim
"       make all comments linewrap/<CR>wrap onto new line
" ====================================================================
" CHANGE LOG
" --------------------------------------------------------------------
" ??-??-2018:  init
" 05-2?-2019:  new files of certain filetype autoinsert this opening
"                 comment header block
" 06-01-2019:  fixed autocomplete braces not holding indents
" 08-01-2019:  added linewrapping
" 03-27-2020:  explicitly set syntax coloring
"              set column numbers
" 04-16-2020:  changed automatic comment header directory to .vim/*
" 08-30-2020:  changed comment#.txt to commentN.txt to avoid errors
" 09-05-2020:  changed tapstop and shiftwidth from 3 to 4
" 10-02-2020:  added .txt to files that open commentN.txt
" 10-11-2020:  made line numbers green
"              changed line wrap from 80 characters to 70
" 03-02-2022:  commented out GoLang channel inoremap ( ,- -> <- )
" 06-20-2022:  commented out GoLang instantiate inoremap ( ;= -> := )
"*04-17-2023:  added txt and book filetypes to commentN.txt
"              added laststatus to always display filename
"
" ====================================================================

" Explicitly set syntax coloring to on
syntax on

" Reset highlight color for comments to lightblue
"hi comment ctermfg=lightblue

" Set line numbering and color of such
set number
hi LineNr ctermfg=Green

" Set column number
set ruler

" Set the amount of spaces in a tab
set tabstop=4

" NFC
set shiftwidth=4

" Replace tab char with spaces
set expandtab

" Copies indent of last line and adds onto <CR>
set autoindent

" Sets character length of line to 70 characters, linewraps
set tw=70

" some way, somehow, this displays the file name at the bottom
set laststatus=2

" Remap {<Enter> with auto close brace and tab in
" THIS COULD BE BETTER, COMBINE WITH AUTOINDENT
inoremap {<CR>       {<CR>f<CR>}<Up><End><Backspace><Tab>

" Close that mf paren
" THIS TAKES TIME, IS IT POSSIBLE TO MAKE IT FASTER
" UPDATE -> this only takes time if you wait for it,
"           typing immediately expedites the process
inoremap (           (  )<Left><Left>

" Skip over closed parens
inoremap ()          ()

" Auto infer declare/instantiate operator for GoLang
"inoremap ;=          :=

" Auto infer channel operator for GoLang
"inoremap ,-          <-
" Auto-insert printf
" TODO:
"        Make language specific shit
"inoremap Print<CR>  printf();<Left><Left>


" Open new files with comment blocks
" Bash, Julia, Ruby, and Text all use pound signs ( # )
" also book-types like Providence, ANO, etc
autocmd BufNewFile *.sh  :r ~/.vim/commentN.txt
autocmd BufNewFile *.jl  :r ~/.vim/commentN.txt
autocmd BufNewFile *.rb  :r ~/.vim/commentN.txt
autocmd BufNewFile *.txt :r ~/.vim/commentN.txt
autocmd BufNewFile *.prv :r ~/.vim/commentN.txt

" Matlab uses percent signs ( % )
autocmd BufNewFile *.m   :r ~/.vim/commentP.txt

" Python uses triple quotes ( """ -> """ )
autocmd BufNewFile *.py  :r ~/.vim/commentQ.txt

" C, Go, and Rust use double slashes
autocmd BufNewFile *.c   :r ~/.vim/commentS.txt
autocmd BufNewFile *.go  :r ~/.vim/commentS.txt
autocmd BufNewFile *.rs  :r ~/.vim/commentS.txt


" So this is how you fuck around
" When g is pressed, it sets the comment color to black, goes back to Insert
" mode, and then types g
" inoremap g           <Esc>:hi comment ctermfg=black<CR>ig

