call plug#begin('~/.vim/plugged')

" General
Plug 'preservim/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'RRethy/vim-illuminate'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-obsession'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ColorSchemes
Plug 'joshdick/onedark.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'Brettm12345/moonlight.vim'
Plug 'yuqio/vim-darkspace'
Plug 'NLKNguyen/papercolor-theme'
Plug 'atahabaki/archman-vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'liuchengxu/space-vim-dark'
Plug 'crusoexia/vim-monokai'
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'danilo-augusto/vim-afterglow'
Plug 'ryanoasis/vim-devicons'

" Python
Plug 'davidhalter/jedi-vim', { 'for': 'python'}
Plug 'sillybun/vim-repl', { 'for': 'python'}

" C#
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs'}

" Flutter
Plug 'jparise/vim-graphql',  { 'for': 'graphql' }
Plug 'reisub0/hot-reload.vim', { 'for': 'dart' }

" Web
Plug 'skammer/vim-css-color'

" Git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

call plug#end()