
set enc=utf-8				"encoding

set lpl						"loading plug-in
set nu						"line number
set title					"title
set nocp					"not Vi, but Vim
set cindent					
set autoindent
set smartindent
set incsearch
set hlsearch
set ruler					"cusror position
set nowrap					"no auto next line 
set ts=4
set showmatch				"(),{},[]

syntax on

"mapping
"map [keyboard] [action]
"ex) map ,1 :b!1<CR>	" move to #1 buffer
map <C-e> :NERDTree<CR>
