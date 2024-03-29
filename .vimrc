" buffer modifiable
set ma

" highlight trailing space NOT
let g:toggleHighlightWhitespace=0

" set Termdebug orientation
let g:termdebug_wide=1

set background=dark
set termguicolors

" italic comments
autocmd ColorScheme * hi Comment cterm=italic gui=italic
" colorscheme bluechia
colorscheme badwolf

au Filetype vimwiki let b:autopairs_loaded=1

nmap a :q
nmap w :w<Enter>

syntax on

nmap <Tab> gt
nmap <C-x> :tabedit 

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set noexpandtab
set backspace=indent,eol,start

" treat ejs files as html
au BufNewFile,BufRead *.ejs set filetype=html

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv']

" for gdb debugging
autocmd FileType c packadd termdebug
autocmd FileType cpp packadd termdebug

" cursor shape
autocmd InsertEnter * silent !echo -ne "\e[6 q"
autocmd InsertLeave * silent !echo -ne "\e[2 q"

" search in sub directories
set path+=**

set number
set relativenumber

set showcmd
set cmdheight=2
nnoremap tv :vert term<Enter>
nnoremap tt :term<Enter>

" auto-complete
set wildmenu

set ruler

" allow color schemes to do bright colors without forcing bold
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" no redraw macros
set lazyredraw

" Indents
set autoindent
set smartindent
set cindent
filetype indent on

" bracket matching
set showmatch

" search highlighting
set incsearch
set hlsearch
set smartcase
set ignorecase

" using ,<space> to remove search highlights
nnoremap <leader><space> :nohlsearch<CR>

" folding of code blocks (all folds open by default)
set foldenable
set foldlevelstart=99

filetype plugin on

" Open/Close Folds
nnoremap <space> za
set foldmethod=indent

nnoremap j gj
nnoremap k gk

" Indent Lines
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" NERDTree Config
set encoding=UTF-8
map <C-o> :NERDTreeToggle<CR>
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
let g:NERDTreeGitStatusConcealBrackets = 1
" let g:NERDTreeGitStatusIndicatorMapCustom = {
"                 \ 'Modified'  :'✹',
"                 \ 'Staged'    :'✚',
"                 \ 'Untracked' :'✭',
"                 \ 'Renamed'   :'➜',
"                 \ 'Unmerged'  :'═',
"                 \ 'Deleted'   :'✖',
"                 \ 'Dirty'     :'✗',
"                 \ 'Ignored'   :'☒',
"                 \ 'Clean'     :'✔︎',
"                 \ 'Unknown'   :'?',
"                 \ }

" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

set spell spelllang=en

" ale
let g:ale_completion_enabled = 1
let g:ale_disable_lsp = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

nmap <silent> <C-f> <Plug>(ale_previous_wrap)
nmap <silent> <C-g> <Plug>(ale_next_wrap)
nnoremap <silent> ]e :ALENext<Enter>
nnoremap <silent> [e : ALEPrevious<Enter>

nnoremap <silent> \\ :split<Enter>
nnoremap <silent> \v :vsplit<Enter>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap zl :vert res +5<Enter>
nnoremap zh :vert res -5<Enter>
nnoremap zj :res +5<Enter>
nnoremap zk :res -5<Enter>

nnoremap <Esc>[1;3A ddkP
nnoremap <Esc>[1;3B ddjP
nnoremap py viwpyiw
nnoremap Fp :echo expand('%')<Enter>
nnoremap FP :echo expand('%:p')<Enter>

source ~/.vim/Plugins.vim
source ~/.vim/InitializeCoc.vim
source ~/.vim/LightlineConfig.vim
source ~/.vim/OmniSharpConfig.vim
source ~/.vim/Shortcuts.vim
