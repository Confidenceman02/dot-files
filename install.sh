#!/usr/bin/env zsh
mkdir ~/.config/nvim
mkdir ~/.config/nvim/lua
mkdir ~/.config/alacritty
cp vimrc ~/.vimrc
# cp coc-settings.json ~/.config/nvim
# cp coc.vim ~/.vim/plugged/coc.nvim/
cp init.vim ~/.config/nvim
cp tmux.conf ~/.tmux.conf
cp alacritty.yml ~/.config/alacritty
cp -R after ~/.config/nvim
cp confidenceman02.lua ~/.config/nvim/lua

# Setup lua dirs
mkdir ~/.config/nvim/lua/lspconfig
mkdir ~/.config/nvim/lua/nvim-cmp
mkdir ~/.config/nvim/lua/cmp
mkdir ~/.config/nvim/lua/luasnip
mkdir ~/.config/nvim/lua/cmp_nvim_lsp
