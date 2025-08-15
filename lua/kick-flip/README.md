# kick-flip

A reliable, cross-environment clipboard provider for Neovim running in a Docker container. This plugin uses a named pipe (FIFO queue) to enable seamless copy/paste between your Neovim session and your host system's clipboard, completely bypassing complex and often unreliable X11 or Wayland forwarding.

## Features

Bidirectional clipboard: Copy from Neovim to your host and paste from your host into Neovim.

Docker-friendly: Built specifically to solve the clipboard-sharing problem in containerized development environments.

Reliable on Wayland/X11: Works reliably by using a file-based communication channel instead of direct display server connections.

Lightweight: The core logic is simple and has a negligible performance impact.

## Prerequisites

Docker Compose: For managing your containerized environment.

A bash-compatible shell for the watcher script.

## Installation

This is a local plugin. To install it, you will need to add the code directly to your Neovim configuration and configure lazy.nvim to load it.

Create the plugin directory structure in your Neovim configuration folder (~/.config/nvim/lua/).

```bash
mkdir -p ~/.config/nvim/lua/kick-flip
```

Create the plugin file init.lua and add the Lua code from the Setup section below.

Add the plugin to your lazy.nvim spec in lazy.lua or plugins.lua.

```lua
{
  "kick-flip",
  init = function()
    vim.opt.clipboard = "unnamedplus"
  end,
  config = function()
    require("kick-flip").setup()
  end,
  desc = "A custom clipboard provider for Docker containers"
}
```

The setup involves three parts: a host-side script, a docker-compose.yml configuration, and the Neovim plugin code.

## 1. Host Machine Setup

Create a dedicated directory and named pipe on your host.

```bash
mkdir -p ~/clipboard_pipe
mkfifo ~/clipboard_pipe/nvim_clipboard
```

Create a clipboard watcher script on your host. This script must be run in a dedicated terminal and uses your host's native clipboard tool (wayland or x11).

wayland: `wl-copy`

x11: `xsel` or `xclip`

clipboard_watcher.sh

```bash
#!/bin/bash

# Path to the named pipe
FIFO_PIPE=~/clipboard_pipe/nvim_clipboard

# Check if the FIFO pipe exists, if not create it
if [ ! -p "$FIFO_PIPE" ]; then
    mkfifo "$FIFO_PIPE"
fi

# The outer loop keeps the script running indefinitely
while true; do
    # The inner loop reads from the pipe and copies to the clipboard
    while read -r line; do
        if [ -n "$line" ]; then
            echo -n "$line" | wl-copy
        fi
    done < "$FIFO_PIPE"
    # A short delay to prevent a busy-loop and handle pipe closures
    sleep 0.1
done
```

## 2. docker-compose.yml

Update your docker-compose.yml file to include a volume mount for the shared directory.

```yaml
version: '3.8'

services:
  the-service:
    # ... other configurations for your service
    volumes:
      - ~/clipboard_pipe:/clipboard_pipe
```

## 3. Neovim Lua Code (~/.config/nvim/lua/kick-flip/init.lua)

This is the core logic of the plugin.

```lua
local M = {}
local clipboard_pipe = "/clipboard_pipe/nvim_clipboard"

M.set_clipboard = function(text)
  if type(text) == 'table' then
    text = vim.fn.join(text, "\n")
  end
  local file = io.open(clipboard_pipe, "w")
  if file then
    file:write(text)
    file:close()
  end
end

M.get_clipboard = function()
  local content = vim.fn.getreg('"')
  if content and #content > 0 then
    return vim.split(content, "\n", { plain = true })
  end
  return {}
end

function M.setup(opts)
  vim.g.clipboard = {
    name = "Nvim_FIFO",
    copy = {
      ['+'] = M.set_clipboard,
      ['*'] = M.set_clipboard,
    },
    paste = {
      ['+'] = M.get_clipboard,
      ['*'] = M.get_clipboard,
    },
  }
  vim.opt.clipboard = "unnamedplus"
end

return M
```
