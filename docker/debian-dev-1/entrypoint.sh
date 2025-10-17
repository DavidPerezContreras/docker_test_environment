#!/bin/bash

echo "🚀 Starting entrypoint.sh"

# Set passwords if provided
/usr/local/bin/password.sh

# Run setup scripts
/usr/local/bin/fix-permissions.sh
/usr/local/bin/keyboard-layout.sh

# Start XRDP in background
/usr/local/bin/start-xrdp.sh &

# Keep container alive
tail -f /dev/null
