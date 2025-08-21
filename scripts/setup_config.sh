#!/bin/bash

# Variables
INIT_FILE="init.lua"
LAZY_LOCK_FILE="lazy-lock.json"
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

if [ -f "$LAZY_LOCK_FILE" ]; then
  echo "Found ${LAZY_LOCK_FILE}."
else
  echo "Error: ${LAZY_LOCK_FILE} does not exist in the current directory."
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
cp "$INIT_FILE" "$NVIM_DIR/$INIT_FILE"
cp "$LAZY_LOCK_FILE" "$NVIM_DIR/$LAZY_LOCK_FILE"

echo "Neovim configuration successfully set up"
