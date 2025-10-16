#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
source "$SCRIPT_DIR/workspace.sh"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "🛠️ Usage:"
  echo "  $0 <template-name> <target-folder-name> <port> [--force]"
  exit 0
fi

TEMPLATE_NAME="$1"
TARGET_NAME="$2"
PORT="$3"
FORCE="$4"
DEFAULT_VOLUME="/mnt/4DF2C69722973221/Development"

TEMPLATE_DIR="$WORKSPACE_ROOT/dev/templates/$TEMPLATE_NAME"
TARGET_DIR="$WORKSPACE_ROOT/docker/$TARGET_NAME"

if [[ -z "$TEMPLATE_NAME" || -z "$TARGET_NAME" || -z "$PORT" ]]; then
  echo "❌ Missing arguments. Run with -h for help."
  exit 1
fi

if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "❌ Template '$TEMPLATE_NAME' not found."
  exit 1
fi

if [[ -d "$TARGET_DIR" && "$FORCE" != "--force" ]]; then
  echo "⚠️ Target folder exists. Use --force to overwrite."
  exit 1
fi

[[ "$FORCE" == "--force" ]] && rm -rf "$TARGET_DIR"

mkdir -p "$TARGET_DIR"

for FILE in "$TEMPLATE_DIR"/*; do
  BASENAME=$(basename "$FILE")
  OUTPUT_NAME="${BASENAME%.template}"
  sed \
    -e "s/{{SERVICE_NAME}}/$TARGET_NAME/g" \
    -e "s/{{PORT}}/$PORT/g" \
    -e "s|{{VOLUME_PATH}}|$DEFAULT_VOLUME|g" \
    "$FILE" > "$TARGET_DIR/$OUTPUT_NAME"
done

echo "✅ Environment '$TARGET_NAME' created at docker/$TARGET_NAME"
