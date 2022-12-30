"■■□□

" text rendering
"set enc=euc-kr
"set fileencoding=euc-kr
set enc=utf-8
set fileencodings=utf-8,cp949

" user interface
set nu                          "line number
set title                       "title
set cursorline
set ruler                       "cusror position
set laststatus=2
set statusline+=%F
set linebreak
if has("syntax")                "syntax highlighting
    syntax on
endif
set nowrap                      "no auto next line
set showmatch                   "(),{},[]

"vi & vim options
set lpl                         "loading plug-in
set nocp                        "not Vi, but Vim

" search
set incsearch                   "increase search
set hlsearch                    "highlight search

" indention
set cindent
set tabstop=4
set shiftwidth=4
set expandtab                   "tab -> space
"set autoindent
"set smartindent
"set softtabstop=4

"locate cursor to last change in code
au BufReadPost *
\ if line("'\"")>0 && line("'\"")<=line("$")|
\ exe "norm g'\""|
\ endif

"mapping
"map [keyboard] [action]
"ex) map ,1 :b!1<CR>    " move to #1 buffer
"map <C-e> :NERDTree<CR>

