#!/bin/bash
echo "🚀 Running Debian Trixie with XFCE and XRDP in Docker..."

# Check for --remove flag
if [[ "$1" == "--remove" ]]; then
    echo "🧹 Removing container 'trixie-xfce'..."
    docker rm -f trixie-xfce 2>/dev/null && echo "✅ Removed." || echo "⚠️ No container to remove."
    exit 0
fi

# Build the image
docker build -t debian-trixie-xfce-xrdp .

# Check if container exists
if docker ps -a --format '{{.Names}}' | grep -q '^trixie-xfce$'; then
    echo "🔄 Container 'trixie-xfce' already exists."

    # Check if it's running
    if docker ps --format '{{.Names}}' | grep -q '^trixie-xfce$'; then
        echo "✅ Container is already running."
    else
        echo "▶️ Starting existing container..."
        docker start trixie-xfce
    fi
else
    echo "📦 Creating and starting new container..."
    docker run -d -p 3389:3389 --name trixie-xfce debian-trixie-xfce-xrdp
fi

echo "🖥️ Connect via RDP to localhost:3389 (user: docker / pass: docker)"
