#!/bin/bash

echo "🔧 Starting entrypoint.sh"

DESKTOP="/home/docker/Desktop"
EXCLUDE="$DESKTOP/Development"

# Fix ownership of Desktop folder itself
chown docker:docker "$DESKTOP"

# Fix ownership recursively for everything inside Desktop except Development
find "$DESKTOP" -mindepth 1 \( -path "$EXCLUDE" -o -path "$EXCLUDE/*" \) -prune -o -exec chown docker:docker {} \;

echo "✅ Finished entrypoint.sh"

# Start the main process
exec "$@"
