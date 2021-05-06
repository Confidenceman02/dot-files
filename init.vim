call plug#begin('~/.vim/plugged')
source $HOME/.vim/plugged/coc.nvim/coc.vim
" --- Auto-Completion
Plug 'jiangmiao/auto-pairs'

" --- Editing ---
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" --- Fuzzy Search ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- Look & Feel
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

" --- Ruby ---
" Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

"--- elm ---
Plug 'Zaptic/elm-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --- SniCppets ---

" --- Syntax Highlighting ---
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

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
if has('nvim')
else
  Plug 'roxma/nvim-yarp'
endif

call plug#end()

syntax on
set rtp+=/usr/local/opt/fzf
set nocompatible
filetype plugin indent on

set encoding=utf8
set autoindent
set backspace=indent,eol,start
set cursorline
set cursorcolumn
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

" Show trailing whitespace, tab characters, etc.
set list
set listchars=tab:>-,trail:.,extends:>

" --- Mappings ---
let mapleader = " "

inoremap jj <ESC>

nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <Tab><Tab> :NERDTreeToggle<CR>

nnoremap <leader>d /def<CR>

nnoremap <leader>cl :lclose<CR>
nnoremap <leader>sn :lnext<cr>
nnoremap <leader>sp :lprev<cr>

nnoremap j gj
nnoremap k gk

" autocmd! BufWritePost,BufEnter * Neomake

" This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR>

" Lets me use space-e to expand emmet abbreviations
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
nmap <leader>e <C-y>,i

" --- FZF ---
nnoremap <leader>p :FZF<cr>

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" --- Look & Feel ---
colorscheme antares
let g:airline_powerline_fonts = 1 "enable powerline font
let g:airline_theme='base16'

" Handy mappings
let g:coc_disable_startup_warning = 1
nnoremap <leader>sv :source $MYVIMRC<cr>

" Key bindings for FZF to make file searching betterer
nnoremap <leader>F :Files<CR>
nnoremap <leader>f :GitFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>H :History:<CR>

" rg bindings
nnoremap <leader>r :Rg<Space>
nnoremap <silent> <Leader>* :Rg <C-R><C-W><CR>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:jsx_ext_required = 0
" let g:javascript_plugin_flow = 1

" --- NERDCommenter options ---
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Sets the sort-motion plugin to be case-insensitive
let g:sort_motion_flags = "i"

" enable AutoSave on Vim startup
let g:auto_save = 1

" --- Inspirational Dotfiles ---
" https://github.com/kmARC/vim/blob/master/vimrc
" Persistent undo 7.3 onwards
if exists("+undofile")
  set undofile
  set undodir=~/.vim/undo,.
endif

" rg 
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -S '.shellescape(<q-args>), 1, { 'options': '--bind ctrl-l:select-all,ctrl-q:deselect-all'  },
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
