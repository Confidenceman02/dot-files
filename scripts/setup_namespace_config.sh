#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi
# Variables
NAMESPACE=$1
INIT_FILE="${NAMESPACE}-init.lua"
NVIM_DIR="$HOME/.config/nvim"
LUA_DIR="$NVIM_DIR/lua"

# Ensure the .config directory exists.
mkdir -p "$NVIM_DIR"

# Check if INIT_FILE exists in the current directory
if [ -f "$INIT_FILE" ]; then
  echo "Found ${INIT_FILE}."
else 
  echo "Error: ${INIT_FILE} does not exist in the current directory."
  exit 1
fi

# Copy the lua directory in to the nvim directory.
if [ -d "lua" ]; then
  cp -R lua "$NVIM_DIR"
else
  echo "Error: 'lua' directory does not exist in the current directory."
  exit 1
fi

# Copy the INIT_FILE into the Neovim lua directory as init.lua
cp "$INIT_FILE" "$NVIM_DIR/init.lua"

# Copy the NAMESPACE directory into the Neovim lua directory
if [ -d "$NAMESPACE" ]; then
  cp -R "$NAMESPACE" "$LUA_DIR"
else
  echo "Error: Namespace directory '$NAMESPACE' does not exist in the current directory."
  exit 1
fi

echo "Neovim configuration successfully set up for namespace '${NAMESPACE}'."

