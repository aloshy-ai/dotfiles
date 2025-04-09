#!/bin/bash

# Create symbolic links for VS Code settings
mkdir -p "$HOME/Library/Application Support/Code/User"
ln -sf "$HOME/.config/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

# Create symbolic links for Cursor settings
mkdir -p "$HOME/Library/Application Support/Cursor/User"
ln -sf "$HOME/.config/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"

echo "Editor configurations linked successfully"
