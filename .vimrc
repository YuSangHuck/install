"■■□□

"encoding
set enc=utf-8

"view
if has("syntax")                "syntax highlighting
    syntax on
endif
set incsearch                   "increase search
set hlsearch                    "highlight search
set ruler					    "cusror position
set nowrap					    "no auto next line 
set showmatch			    	"(),{},[]
set nu					    	"line number
set title				    	"title

"vi & vim options
set lpl						    "loading plug-in
set nocp					    "not Vi, but Vim

"auto indent
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
"ex) map ,1 :b!1<CR>	" move to #1 buffer
map <C-e> :NERDTree<CR>
