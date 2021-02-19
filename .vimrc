" highlight trailing space NOT
let g:toggleHighlightWhitespace=0

set background=dark
set termguicolors

" afterglow
let g:afterglow_blackout=1
let g:afterglow_italic_comments=1
colorscheme afterglow

" syntax highlighting
syntax on

" underline current line
" set cursorline
" hi clear CursorLine
" hi CursorLine gui=underline cterm=underline

" tab mode
nmap <Tab> gt
nmap <C-x> :tabedit 

" spacing
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set noexpandtab
set backspace=indent,eol,start

" cursor shape
autocmd InsertEnter * silent !echo -ne "\e[6 q"
autocmd InsertLeave * silent !echo -ne "\e[2 q"

" search in sub directories
set path+=**

" omnisharp
" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation pop-up background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
" Contextual code actions (uses fzf, CtrlP or unite.vim selector when available)
"autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
"autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Enable snippet completion, using the ultisnips plugin
let g:OmniSharp_want_snippet=1


"======================================COC=====================================
" coc sample config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"Super tab settings
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"=============================================================================

" line number
set number
set relativenumber

" terminal
set showcmd

" auto-complete
set wildmenu

" ruler
set ruler

" allow color schemes to do bright colors without forcing bold
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" no redraw macros
set lazyredraw

" indents
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

" to make vim read the after/ftplugin folder
filetype plugin on

" open/close folds
nnoremap <space> za

" fold by indent
set foldmethod=indent

" easier navigation
nnoremap j gj
nnoremap k gk

" indent lines
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" nerd tree additional
map <C-o> :NERDTreeToggle<CR>
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" spell check
set spell spelllang=en

" ALE completion
let g:ale_completion_enabled = 1

" split navigations
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" correction for lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }
      
" ale settings
nmap <silent> <C-f> <Plug>(ale_previous_wrap)
nmap <silent> <C-g> <Plug>(ale_next_wrap)

" quit and save
nmap a :q
nmap w :w<Enter>

" web
autocmd FileType html nnoremap <F6> :!xdg-open %<Enter>

" rust
"let g:rustfmt_autosave = 1
"autocmd FileType rust nnoremap <C-b> :!rustc %<Enter>
"autocmd FileType rust nnoremap <C-x> :!clear && ./%:r<Enter>

" go
"autocmd FileType go nnoremap <C-f> :!clear && go run %<Enter>
"autocmd FileType go nnoremap <C-b> :!go build %<Enter>
"autocmd FileType go nnoremap <C-x> :!clear && ./%:r<Enter>
      
" python
" let g:pymode_run_bind = '<C-r>'
autocmd Filetype python nnoremap <F6> :!clear && python3 %<Enter>
autocmd Filetype python nnoremap t<F6> :term python3 %<Enter>
autocmd Filetype python nnoremap tv<F6> :vert term python3 %<Enter>

" c/cpp
autocmd FileType cpp nnoremap t<C-b> :term g++ -o  %:r %<Enter>
autocmd FileType cpp nnoremap tv<C-b> :vert term g++ -o  %:r %<Enter>
autocmd FileType cpp nnoremap <C-b> :!g++ -o  %:r %<Enter>
autocmd FileType cpp nnoremap t<F6> :term g++ -o  %:r % && clear && ./%:r<Enter>
autocmd FileType cpp nnoremap tv<F6> :vert term g++ -o  %:r % && clear && ./%:r<Enter>
autocmd FileType cpp nnoremap <F6> :!g++ -o  %:r % && clear && ./%:r<Enter>
autocmd FileType c nnoremap t<C-b> :term g++ -o  %:r % -lgraph<Enter>
autocmd FileType c nnoremap tv<C-b> :vert term g++ -o  %:r % -lgraph<Enter>
autocmd FileType c nnoremap <C-b> :!g++ -o  %:r % -lgraph<Enter>
autocmd FileType c nnoremap t<F6> :term g++ -o  %:r % -lgraph && clear && ./%:r<Enter>
autocmd FileType c nnoremap tv<F6> :vert term g++ -o  %:r % -lgraph && clear && ./%:r<Enter>
autocmd FileType c nnoremap <F6> :!g++ -o  %:r % -lgraph && clear && ./%:r<Enter>

" c#
autocmd FileType cs nnoremap t<C-b> :term mcs %<Enter>
autocmd FileType cs nnoremap tv<C-b> :vert term mcs %<Enter>
autocmd FileType cs nnoremap <C-b> :!mcs %<Enter>
autocmd FileType cs nnoremap t<F6> :term mcs % && clear && ./%:r.exe<Enter>
autocmd FileType cs nnoremap tv<F6> :vert term mcs % && clear && ./%:r.exe<Enter>
autocmd FileType cs nnoremap <F6> :!mcs % && clear && ./%:r.exe<Enter>

" java
"autocmd FileType java nnoremap <C-f> :!clear && java %<Enter>
"autocmd FileType java nnoremap <C-b> :!javac %<Enter>
"autocmd FileType java nnoremap <F6> :!javac % && clear && java %:r<Enter>

" kotlin
"autocmd FileType kotlin nnoremap <C-b> :!kotlinc % -include-runtime -d %:r.jar<Enter>
"autocmd FileType kotlin nnoremap <F6> :!kotlinc % -include-runtime -d %:r.jar && clear && java -jar %:r.jar<Enter>

" vim-plug
call plug#begin('~/.vim/plugged')

" General
Plug 'preservim/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'RRethy/vim-illuminate'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
" Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-obsession'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'skywind3000/asyncrun.vim'

" ColorSchemes
Plug 'joshdick/onedark.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'yuqio/vim-darkspace'
Plug 'lewis6991/moonlight.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'atahabaki/archman-vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'liuchengxu/space-vim-dark'
Plug 'crusoexia/vim-monokai'
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'danilo-augusto/vim-afterglow'

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'davidhalter/jedi-vim', { 'for': 'python'}
Plug 'sillybun/vim-repl', { 'for': 'python'}

" Go
"Plug 'fatih/vim-go', { 'for': 'go'}
"Plug 'nsf/gocode', { 'for': 'go'}

" C#
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs'}

" Rust
"Plug 'rust-lang/rust.vim', { 'for': 'rust'}
"Plug 'rust-lang/rustfmt', { 'for': 'rust'}

" Java
"Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java'}

" Kotlin
"Plug 'udalov/kotlin-vim', { 'for': 'kotlin'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" Web
Plug 'ap/vim-css-color'

call plug#end()
