#!/bin/bash

# Define the user's home directory
USER_HOME="/home/docker"

# Ensure home directory exists
if [ ! -d "$USER_HOME" ]; then
    echo "User home directory not found: $USER_HOME"
    exit 1
fi

# Create .xprofile to set Spanish keyboard layout and debug marker
cat <<EOF > "$USER_HOME/.xprofile"
#!/bin/bash
setxkbmap es
EOF

# Set permissions
chmod +x "$USER_HOME/.xprofile"
chown docker:docker "$USER_HOME/.xprofile"

echo "✅ Spanish keyboard layout configured via .xprofile"

