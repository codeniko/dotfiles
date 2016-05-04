set t_Co=256
set background=dark
colorscheme molokai
" let g:molokai_original = 1
let g:rehash256 = 1 " Use Molokai's new version

" Sets the value of <LEADER> (default is the backslash)
let mapleader=","

set encoding=utf-8

" " Common mappings
map Y y$

" nmap <LEADER>s :write<CR>
nnoremap <LEADER>a ggVG

" " Reload config file
nmap <LEADER>r :source ~/.vimrc<CR>

" " Yanking and pasting to the clipboard
noremap <LEADER>y "+y
noremap <LEADER>p "+p

" " Clear search and match highlighting
nmap <SPACE> :match none<CR>:nohlsearch<CR>

" Backups {{{
set backup " enable backups
"     set noswapfile "disable backups
set backupdir=~/.vim/backup/tmp " backups
set directory=~/.vim/swap/ " swap files
" Create dirs if they don't exist
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

" Simplify tag style by removing underlines
hi TabLine term=none cterm=none ctermfg=15 ctermbg=242 gui=underline guibg=DarkGrey
set backspace=indent,eol,start " Backspace over these characters
set nocompatible "This fixes the problem where arrow keys do not function properly on some systems.
syntax on  "Enables syntax highlighting for programming languages
" set mouse=a  "Allows you to click around the text editor with your mouse to move the cursor
" set mouse=n " Turn on mouse support in normal mode
set showmatch "Highlights matching brackets in programming languages
set cursorline " Highlight current line
set ruler " display line and columns in the status bar
set backspace=2  "This makes the backspace key function like it does in other programs.
set showcmd " Display commands as they are typed
set number  "Enables line numbering
" set nowrap " Turn off line wrapping
set expandtab
set smarttab  "Improves tabbing
set autoindent  "If you're indented, new lines will also be indented
set smartindent  "Automatically indents lines after opening a bracket in programming languages
set smartcase "ignore case on search unless specified
set pastetoggle=<F2>
set tabstop=2  "How much space Vim gives to a tab
set shiftwidth=2  "Assists code formatting, indenting with  << >>
autocmd BufRead,BufNewFile   *.less,*.jsx,*.html,*.css set expandtab smarttab tabstop=2 shiftwidth=2
""--- The following commands make the navigation keys work like standard editors
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
" Old full page scrolling
nmap <C-Down> <C-f>
nmap <C-Up> <C-b>

" Navigation on physical lines, instead of display
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Compile Latex when I save it.
au BufWritePost *.tex "silent !pdflatex %"

" Removes #, ", and // auto comment insertions
inoremap <expr> <enter> getline('.') =~ '^\s*[#"//]' ? '<enter><esc>S' : '<enter>'
nnoremap <expr> O getline('.') =~ '^\s*[#"//]' ? 'O<esc>S' : 'O'
nnoremap <expr> o getline('.') =~ '^\s*[#"//]' ? 'o<esc>S' : 'o'

" Split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-N> :vnew<CR>
nnoremap <C-E> :vsplit<SPACE>
set splitbelow " open new splits below
set splitright " open new split to the right
" move window to new tab
nnoremap <C-T> :tabedit %<CR>

" Tabs
nmap gn :tabnew<CR>
nmap ge :tabedit<SPACE>
nmap gl :tabnext<CR>
nmap gh :tabprev<CR>

" Folds
set foldmethod=indent
set foldlevel=0
set foldclose=all
" Set mapping to disable/enable auto fold close
nmap z<S-a> :set foldclose=all
nmap za :set foldclose=
" Disable folding on startup
autocmd BufWinEnter * exe "normal! zn"

" Other interesting commands
nmap <F9> :%TOhtml
command! Sudow :w !sudo dd of=%
command! InstallPlugins :PluginInstall

" VUNDLE
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:

" Syntax checker
Bundle 'scrooloose/syntastic'
" disable `no docs` error checking
let syntastic_gjslint_conf= '--nojsdoc'
let g:syntastic_java_javac_config_file_enabled= 1

" YouCompleteMe replaces this
" C/C++ language completion
" Bundle 'Rip-Rip/clang_complete'
" let g:clang_complete_auto = 1
" let g:clang_use_library = 1
" let g:clang_debug = 1
" let g:clang_library_path = '/usr/lib'

" Commenting with gcc binding
" Bundle 'tomtom/tcomment_vim' 

" File navigation
Bundle 'kien/ctrlp.vim'

" Navigation with keyboard
Bundle 'Lokaltog/vim-easymotion' 
let g:EasyMotion_leader_key = '<Leader>'

" Ctags improvement, F5 to open tagbar
Bundle 'majutsushi/tagbar'
nmap <F5> :TagbarToggle<CR>

" Matches closing parens,quotes,def/ends
" Bundle 'tsaleh/vim-matchit'

" Navigate between tmux and vim
Bundle 'christoomey/vim-tmux-navigator'

" jsx plugin
Bundle 'mxw/vim-jsx'

Bundle 'jakar/vim-json'
Bundle 'pangloss/vim-javascript'
let g:javascript_enable_domhtmlcss = 1 " Enables HTML/CSS syntax highlighting in your JavaScript file.


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

