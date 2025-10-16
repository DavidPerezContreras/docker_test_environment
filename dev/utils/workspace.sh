#!/bin/bash

# Detect workspace root by walking up from current directory
detect_workspace_root() {
  local dir="$(pwd -P)"  # resolve to full physical path
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/dev/utils" && -d "$dir/docker" ]]; then
      echo "$dir"
      return
    fi
    dir="$(dirname "$dir")"
  done
  echo ""
}

WORKSPACE_ROOT="$(detect_workspace_root)"

if [[ -z "$WORKSPACE_ROOT" ]]; then
  echo "❌ Error: Must run this command from inside a workspace folder."
  exit 1
fi
