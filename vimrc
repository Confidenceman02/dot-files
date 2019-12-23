call plug#begin('~/.vim/plugged')
execute pathogen#infect()

" --- Auto-Completion
Plug 'jiangmiao/auto-pairs'
Plug 'Valloric/YouCompleteMe'

" --- Editing ---
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" --- Fuzzy Search ---
Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/junegunn/fzf.vim'

" --- Linting ---
Plug 'w0rp/ale'

" --- Look & Feel
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

" --- Ruby ---
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" --- Snippets ---
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/Emmet.vim'

" --- Syntax Highlighting ---
" Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/WebAPI.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'elzr/vim-json'
Plug 'https://github.com/othree/yajs.vim'
Plug 'https://github.com/jelera/vim-javascript-syntax'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'https://github.com/othree/es.next.syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" --- typescript ---
Plug 'Quramy/tsuquyomi'
" --- Text Objects ---
Plug 'christoomey/vim-sort-motion'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'

" --- TMUX ---
Plug 'christoomey/vim-tmux-navigator'

" --- Tools ---
Plug 'https://github.com/junegunn/vim-plug'
Plug '907th/vim-auto-save'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'https://github.com/tpope/vim-eunuch'

call plug#end()

syntax on

set nocompatible
filetype plugin indent on


set encoding=utf8
set autoindent
set backspace=indent,eol,start
" set cursorline
" set cursorcolumn
set hidden
set hlsearch
set laststatus=2
set relativenumber
set number
set ruler
set scrolloff=3
set showcmd
set showmode
set ttyfast
set undofile
set visualbell
set wildmenu
set wildmode=list:longest
set modelines=0

" --- Tabs ---
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" --- Mappings ---
let mapleader = " "
inoremap jj <ESC>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>b :Buffers<cr>
nnoremap <Tab><Tab> :NERDTreeToggle<CR>
nnoremap <leader>d /def<CR>
nnoremap <leader>cl :lclose<CR>
nnoremap <leader>sn :lnext<cr>
nnoremap <leader>sp :lprev<cr>
nnoremap j gj
nnoremap k gk

" This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

" Lets me use space-e to expand emmet abbreviations
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
nmap <leader>e <C-y>,i

" --- FZF ---
nnoremap <leader>p :FZF<cr>
nnoremap <leader>F :Files<cr>

" rg bindings
nnoremap <leader>r :Rg<Space>
nnoremap <silent> <Leader>* :Rg <C-R><C-W><CR>
" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" --- ALE ---

let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = '/Users/Jaime/.nvm/versions/node/v8.6.0/bin/eslint'
let g:ale_fixers = {'javascript': ['eslint']}

" --- Look & Feel ---
colorscheme alduin
let g:airline_powerline_fonts = 1 "enable powerline font
let g:airline_theme='base16'

" ts intellisense
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:ycm_log_level='debug'
" Other options "
"""""""""""""""""
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

" --- NERDCommenter options ---
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Sets the sort-motion plugin to be case-insensitive
let g:sort_motion_flags = "i"

" Use a custom emmet snippets file
" let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.snippets.json')), "\n"))

" enable AutoSave on Vim startup
let g:auto_save = 1

" rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -S '.shellescape(<q-args>), 1, { 'optionss': '--bind ctrl-l:select-all,ctrl-q:deselect-all'  },
  \   <bang>0)

command! -bang -nargs=* RgWithPreview
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -S '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
 \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" or GitFiles
command! -bang -nargs=? -complete=dir GitFiles
 \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

