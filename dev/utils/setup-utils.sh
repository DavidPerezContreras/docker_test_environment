#!/bin/bash

# 📁 Resolve workspace root from inside dev/utils/
WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
UTILS_DIR="$WORKSPACE_DIR/dev/utils"
BIN_DIR="$WORKSPACE_DIR/bin"

echo "🔧 Setting up utility scripts..."

# Create bin/ if it doesn't exist
mkdir -p "$BIN_DIR"

# Symlink all .sh files from dev/utils to bin/
for file in "$UTILS_DIR"/*.sh; do
  filename=$(basename "$file")
  linkname="${filename%.sh}"  # remove .sh extension for cleaner command
  ln -sf "$file" "$BIN_DIR/$linkname"
  echo "🔗 Linked: $linkname → $file"
done

# Add bin/ to PATH if not already present
if ! grep -q "$BIN_DIR" <<< "$PATH"; then
  echo "📌 Adding bin/ to PATH in ~/.bashrc..."
  echo "export PATH=\"$BIN_DIR:\$PATH\"" >> ~/.bashrc
  echo "✅ Reload your shell or run: source ~/.bashrc"
else
  echo "✅ bin/ is already in your PATH."
fi

echo "🎉 All utility scripts in dev/utils/ are now available globally!"
