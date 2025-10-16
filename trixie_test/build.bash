#!/bin/bash
echo "🚀 Building Debian Trixie with XFCE and XRDP Docker image..."

# Check for --remove flag
if [[ "$1" == "--remove" ]]; then
    echo "🧹 Removing image 'debian-trixie-xfce-xrdp'..."
    docker image rm debian-trixie-xfce-xrdp 2>/dev/null && echo "✅ Removed." || echo "⚠️ No image to remove."
    exit 0
fi

# Check for --no-cache flag
if [[ "$1" == "--no-cache" ]]; then
    echo "🔄 Building image without cache..."
    docker build --no-cache -t debian-trixie-xfce-xrdp .
else
    docker build -t debian-trixie-xfce-xrdp .
fi

echo "✅ Image 'debian-trixie-xfce-xrdp' built successfully."
echo "📦 You can now use this image in your docker-compose.yaml files."
