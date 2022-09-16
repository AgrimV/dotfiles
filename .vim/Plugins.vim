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
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-obsession'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
" Causes issues with Plug commands
" Plug 'TaDaa/vimade' " Fade Inactive Buffers
Plug 'lilydjwg/colorizer'
" Plug 'tribela/vim-transparent'
" Transparent[Enable, Disable, Toggle]

" ColorSchemes
Plug 'joshdick/onedark.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'Brettm12345/moonlight.vim'
Plug 'yuqio/vim-darkspace'
Plug 'NLKNguyen/papercolor-theme'
Plug 'danilo-augusto/vim-afterglow'
Plug 'liuchengxu/space-vim-dark'
Plug 'crusoexia/vim-monokai'
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'danilo-augusto/vim-afterglow'
Plug 'catppuccin/vim', { 'as': 'catppuccin'}

" C#
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs'}

" Flutter
Plug 'jparise/vim-graphql',  { 'for': 'graphql' }
Plug 'AgrimV/hot-reload.vim', { 'for': 'dart' }

" OpenGL Shaders
Plug 'tikhomirov/vim-glsl'

" Web
Plug 'skammer/vim-css-color'

" Git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

call plug#end()
