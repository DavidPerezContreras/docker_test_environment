#!/bin/bash

# Show help if -h or --help is passed
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "🛠️ Usage:"
  echo "  $0 <template-name> <target-folder-name> <port> [--force]"
  echo
  echo "📦 Arguments:"
  echo "  <template-name>       Name of the template folder inside dev/templates/"
  echo "  <target-folder-name>  Name of the folder to create inside docker/"
  echo "  <port>                Port to expose for the service (e.g. 6000)"
  echo "  --force               Optional: overwrite existing folder if it already exists"
  echo
  echo "📁 Example:"
  echo "  $0 debian-dev debian-dev-2 6010 --force"
  exit 0
fi

# Arguments
TEMPLATE_NAME="$1"
TARGET_NAME="$2"
PORT="$3"
FORCE="$4"
DEFAULT_VOLUME="/mnt/4DF2C69722973221/Development"

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/../templates/$TEMPLATE_NAME"
TARGET_DIR="$SCRIPT_DIR/../../docker/$TARGET_NAME"

# Validate input
if [[ -z "$TEMPLATE_NAME" || -z "$TARGET_NAME" || -z "$PORT" ]]; then
  echo "❌ Missing arguments."
  echo "Run with -h for help: $0 -h"
  exit 1
fi

if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "❌ Template '$TEMPLATE_NAME' not found in dev/templates/"
  exit 1
fi

if [[ -d "$TARGET_DIR" && "$FORCE" != "--force" ]]; then
  echo "⚠️ Target folder 'docker/$TARGET_NAME' already exists. Use --force to overwrite."
  exit 1
fi

if [[ -d "$TARGET_DIR" && "$FORCE" == "--force" ]]; then
  echo "🔄 Overwriting existing folder 'docker/$TARGET_NAME'..."
  rm -rf "$TARGET_DIR"
fi

# Create target folder and copy template with replacements
mkdir -p "$TARGET_DIR"

for FILE in "$TEMPLATE_DIR"/*; do
  BASENAME=$(basename "$FILE")
  OUTPUT_NAME="${BASENAME%.template}"  # Strip .template extension
  sed \
    -e "s/{{SERVICE_NAME}}/$TARGET_NAME/g" \
    -e "s/{{PORT}}/$PORT/g" \
    -e "s|{{VOLUME_PATH}}|$DEFAULT_VOLUME|g" \
    "$FILE" > "$TARGET_DIR/$OUTPUT_NAME"
done

echo "✅ Environment '$TARGET_NAME' created from template '$TEMPLATE_NAME' using port $PORT."
echo "📁 Location: docker/$TARGET_NAME"
