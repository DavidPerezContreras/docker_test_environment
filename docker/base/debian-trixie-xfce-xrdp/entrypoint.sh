#!/bin/bash

echo "🔧 Starting entrypoint.sh"

DESKTOP="/home/docker/Desktop"
EXCLUDE="$DESKTOP/Development"

# Fix Desktop folder itself
chown docker:docker "$DESKTOP"
chmod 755 "$DESKTOP"

# Fix everything inside Desktop except Development
find "$DESKTOP" -mindepth 1 \( -path "$EXCLUDE" -o -path "$EXCLUDE/*" \) -prune -o -exec chown docker:docker {} \;
find "$DESKTOP" -mindepth 1 \( -path "$EXCLUDE" -o -path "$EXCLUDE/*" \) -prune -o -exec chmod 755 {} \;

echo "✅ Finished permission fix"

# Start XRDP
exec /usr/local/bin/start-xrdp.sh