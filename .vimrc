set t_Co=256
" set background=dark
colorscheme sonoma " molokai
" let g:molokai_original = 1
" let g:rehash256 = 1 " Use Molokai's new version

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

set hlsearch " highlight search terms
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
set tabstop=4  "How much space Vim gives to a tab
set softtabstop=4
set shiftwidth=4  "Assists code formatting, indenting with  << >>
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
" nnoremap k gk
" nnoremap j gj
" nnoremap gk k
" nnoremap gj j

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
nmap gc :tabedit %<CR>

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
nnoremap <space> za
" Disable folding on startup
autocmd BufWinEnter * exe "normal! zn"
" disable folding on startup for scala filetypes, vim-scala overrides above
autocmd filetype scala exe "normal! zn"
autocmd filetype java exe "UnusedImports"

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
"Bundle 'scrooloose/syntastic'
" disable `no docs` error checking
"let syntastic_gjslint_conf= '--nojsdoc'
"let g:syntastic_java_javac_config_file_enabled= 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
"let g:syntastic_mode_map = {
"    \ "mode": "active",
"    \ "active_filetypes": [],
"    \ "passive_filetypes": ["scala", "sbt", "py"] }

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
Bundle 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
let g:ctrlp_user_command = {
  \ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files'],
  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': 'ag %s -i --nocolor --nogroup --hidden
  \ --ignore out
  \ --ignore .git
  \ --ignore .svn
  \ --ignore .hg
  \ --ignore .DS_Store
  \ --ignore "**/*.pyc"
  \ -g ""'
  \ }

" Navigation with keyboard
Bundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>'

" Ctags improvement, F5 to open tagbar
Bundle 'majutsushi/tagbar'

Bundle 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1 " close autocomplete window
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> " shortcut for goto definition


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

Bundle 'derekwyatt/vim-scala'
" Plugin 'dscleaver/sbt-quickfix' " use <leader>ff to open quickfix
Bundle 'akhaku/vim-java-unused-imports'

" colors are highlighted in their color
Bundle 'chrisbra/Colorizer'

" ability to show diff between swap file and file being opened
Bundle 'chrisbra/Recover.vim'

" better status/tabline
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
let g:airline_theme='molokai'

" show changes +/-/~ when editing file
Bundle 'airblade/vim-gitgutter'

" git wrapper
Bundle 'tpope/vim-fugitive'

" Ctrl S to split a selection out to own buffer to modify and then write back
Bundle 'chrisbra/NrrwRgn'
vmap <C-s> :'<,'>NR<CR>

Bundle 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if nerdtree is the only window open
" open nerdtree automatically and go to right window
" autocmd vimenter * NERDTree
" autocmd vimenter * wincmd p
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('less', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('java', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('scala', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('c', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('cpp', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('h', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"
" original repos on GitHub
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


"Always open help files in a rightward vertical split
cnoreabbrev <expr> help ((getcmdtype() is# ':'    && getcmdline() is# 'help')?('vert help'):('help'))
cnoreabbrev <expr> h ((getcmdtype() is# ':'    && getcmdline() is# 'h')?('vert help'):('h'))

" vertical split diff
set diffopt+=vertical

" show relative number line to current line, but show current line absolute line numbe
set relativenumber
set number

" visual select to search selection
vnoremap g/ y/<C-R>"<CR>

" add quotes around selection
vnoremap qq <Esc>`>a'<Esc>`<i'<Esc>

" highlight trailiing whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.sbt,*.scala,*.js,*.jsx,*.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" python PEP8 indentation
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

Bundle 'vim-scripts/indentpython.vim'
" PEP8 lint
Bundle 'nvie/vim-flake8'
let python_highlight_all=1

"python with virtualenv support, setup system path so Youcompleteme finds
"appropriate site packages
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
