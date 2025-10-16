#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
source "$SCRIPT_DIR/workspace.sh"

BIN_DIR="$WORKSPACE_ROOT/bin"
UTILS_DIR="$WORKSPACE_ROOT/dev/utils"

echo "🔧 Setting up utility scripts..."

mkdir -p "$BIN_DIR"

for file in "$UTILS_DIR"/*.sh; do
  filename=$(basename "$file")
  linkname="${filename%.sh}"
  ln -sf "$file" "$BIN_DIR/$linkname"
  echo "🔗 Linked: $linkname → $file"
done

if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  echo "📌 Adding bin/ to PATH in ~/.bashrc..."
  echo "export PATH=\"$BIN_DIR:\$PATH\"" >> ~/.bashrc
  echo "🔄 Reloading shell configuration..."
  source ~/.bashrc
else
  echo "✅ bin/ is already in your PATH."
fi

echo "🎉 Utility scripts are now available from workspace root!"
