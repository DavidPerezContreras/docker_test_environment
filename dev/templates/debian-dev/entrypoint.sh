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

echo "🌐 Setting keyboard layout to Spanish (Windows)"

# Set system-wide keyboard layout
localectl set-keymap es
localectl set-x11-keymap es pc105

# Set XRDP keyboard layout (Spanish layout code: 0000040A)
sed -i 's/^keyboard_layout=.*/keyboard_layout=0x0000040A/' /etc/xrdp/xrdp.ini

echo "✅ Keyboard layout set to Spanish"

# Start XRDP
exec /usr/local/bin/start-xrdp.sh
