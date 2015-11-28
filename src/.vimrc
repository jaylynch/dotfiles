set nocompatible

" Keep longer history
set history=10000

" Search (ignore case unless upper, show matches, wrap)
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set wrapscan

" Enable filetypes and syntax highlighting
filetype on
filetype plugin on
filetype indent on
syntax enable

" Whitespace (2 tabs, soft, clever)
set autoindent
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftround

" Line numbers
set number
set numberwidth=5

" Highlight current line
set cul

" Wildmenu
set wildmenu

" Scrolling
set scrolloff=4

" Colours
:set t_Co=256
:set background=dark
colorscheme wombat256mod

" Status bar
set laststatus=2

" Hide menubar, toolbar in gvim
:set guioptions-=M
:set guioptions-=T

" Set syntax highlighting for nginx config files
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif

" Highlight column 78
set cc=79

" Highlight lines running longer than 80 chars
highlight OverLength ctermbg=darkred ctermfg=white guibg=#390909
match OverLength /\%80v.\+/

