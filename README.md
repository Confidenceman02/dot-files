# File set up

This guide assumes you are using [nvim](https://www.google.com) and the [vim-plug](https://github.com/junegunn/vim-plug) plugin manager.

## Install coc-vim
 
Source the `coc.vim` file which has a bunch of sensible defaults for the [neoclide/coc-vim](https://github.com/neoclide/coc.nvim) plugin. You can find it in [documentation](https://github.com/neoclide/coc.nvim).
You can place this wherever you like as long as you source it correctly.
```
" nvim.init
source $HOME/.vim/plugged/coc.nvim/coc.vim
``` 

Add the [neoclide/coc-vim](https://github.com/neoclide/coc.nvim) plugin to your nvim.init file.
```
" nvim.init
Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

Install the plugin.
`: PlugInstall`

## Working with vim and elm
[coc-vim](https://github.com/neoclide/coc.nvim) needs the [elm-language-server](https://github.com/elm-tooling/elm-language-server) to make your vim development vscode like.

```
npm install -g @elm-tooling/elm-language-server
```

Add the `elm-tooling.json` file found in this directory to the root directory of your elm project.
It has some sensible defaults but change as needed.

NOTE: You can just have one global `elm-tooling.json` file but I prefer to have them on a per project basis.

`cp elm-tooling.json ~/path/to/your/project/root`

`elm-language-server` needs to install elm things into its own internally managed directory.

from the root of your porject or directory where `elm-tooling.json` lives.

`npx elm-tooling install`

Now you need to configure [coc-vim](https://github.com/neoclide/coc.nvim) to work with `elm-language-server`. You do this via the `coc-settings.json` file.

You can copy `coc-settings.json` in this file to the location [coc-vim](https://github.com/neoclide/coc.nvim) is expecting it.

`cp coc-settings.json ~/.config/nvim/coc-settings.json`

Alternatively you can edit the config file from a vim session.

`: CocConfig`

Copy and past everything from `coc-settings.json` into this buffer then `:wq`

All should be working so open up an elm file and you should have a vscode style experience.

## Install Coc extensions
These are some nice extensions to have. Make sure you check out the extension documentation to configure to your liking.
I have found they all just work out of the box well enough.

- coc-explorer
- coc-tsserver
- coc-json
- coc-vimlsp
- coc-prettier

[coc-vim](https://github.com/neoclide/coc.nvim) extensions can be installed whilst in a vim session.

`: CocInstall coc-prettier coc-json ...`