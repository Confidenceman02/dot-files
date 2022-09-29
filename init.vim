let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

lua require("confidenceman02")

call plug#begin("~/.config/nvim/autoload")
" --- Auto-Completion
Plug 'jiangmiao/auto-pairs'

" --- Editing ---
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" --- auto complete ---
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

" --- Fuzzy Search ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- Look & Feel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim'

"--- haskell ---
Plug 'neovimhaskell/haskell-vim'

" --- Syntax Highlighting ---
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

" --- TMUX ---
Plug 'christoomey/vim-tmux-navigator'

" --- Tools ---
Plug 'https://github.com/junegunn/vim-plug'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
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

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

set autoindent
set backspace=indent,eol,start
set colorcolumn=80
set cursorline
set cursorcolumn

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set hlsearch
set laststatus=2
set relativenumber
set number
set ruler
set scrolloff=8
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

nnoremap <leader>d /def<CR>
nnoremap <leader>cl :lclose<CR>
nnoremap <leader>sn :lnext<cr>
nnoremap <leader>sp :lprev<cr>
nnoremap j gj
nnoremap k gk
" This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR>

" --- FZF ---
nnoremap <leader>p :FZF<cr>

" --- Look & Feel ---
colorscheme ayu
set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme

let g:airline_powerline_fonts = 1 "enable powerline font
let g:airline_theme='base16'

" Handy mappings
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

autocmd BufWritePre *.elm lua vim.lsp.buf.formatting_sync()
autocmd FileType haskell autocmd BufWritePre <buffer> call CocAction('format')
let g:haskell_indent_disable=1

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

" Sets the sort-motion plugin to be case-insensitive
let g:sort_motion_flags = "i"

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
