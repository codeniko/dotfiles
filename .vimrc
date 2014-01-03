set t_Co=256
set background=dark
colorscheme molokai
" let g:molokai_original = 1

" Sets the value of <LEADER> (default is the backslash)
let mapleader=","

" " Common mappings
map Y y$
nmap <C-z> :undo<CR>
nmap <C-y> :redo<CR>
nmap <LEADER>s :write<CR>
nnoremap <LEADER>a ggVG

" " Reload config file
nmap <LEADER>r :source ~/.vimrc<CR>

" " Yanking and pasting to the clipboard
noremap <LEADER>y "+y
noremap <LEADER>p "+p

" " Clear search and match highlighting
nmap <SPACE> :match none<CR>:nohlsearch<CR>


set nocompatible "This fixes the problem where arrow keys do not function properly on some systems.
syntax on  "Enables syntax highlighting for programming languages
set mouse=a  "Allows you to click around the text editor with your mouse to move the cursor
" set showmatch "Highlights matching brackets in programming languages
set autoindent  "If you're indented, new lines will also be indented
set smartindent  "Automatically indents lines after opening a bracket in programming languages
set cursorline " Highlight current line
set backspace=2  "This makes the backspace key function like it does in other programs.
set tabstop=4  "How much space Vim gives to a tab
set number  "Enables line numbering
set smarttab  "Improves tabbing
set shiftwidth=4  "Assists code formatting
set foldmethod=manual  "Lets you hide sections of code
""--- The following commands make the navigation keys work like standard editors
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
set smartcase "ignore case on search unless specified
"--- Ends navigation commands
""--- The following adds a sweet menu, press F4 to use it.
source $VIMRUNTIME/menu.vim
set wildmenu
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>
"--- End sweet menu



"VUNDLE

filetype off                 " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
Bundle 'scrooloose/syntastic'
Bundle 'Rip-Rip/clang_complete'
let g:clang_complete_auto = 1
let g:clang_use_library = 1
let g:clang_debug = 1
let g:clang_library_path = '/usr/lib'
Bundle 'tomtom/tcomment_vim'
Bundle 'kien/ctrlp.vim'

Bundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>'


"
" original repos on GitHub
"Bundle 'tpope/vim-fugitive'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non-GitHub repos
"Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required!
" filetype on
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

