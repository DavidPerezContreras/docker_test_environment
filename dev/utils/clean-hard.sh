#!/bin/bash

# 🚨 WARNING: This will delete ALL Docker containers, images, volumes, and cache.

echo "🧹 Starting full Docker cleanup..."

# Stop and remove all containers
echo "🛑 Stopping containers..."
docker ps -aq | xargs -r docker stop

echo "🗑️ Removing containers..."
docker ps -aq | xargs -r docker rm

# Remove all images
echo "🧯 Removing images..."
docker images -q | xargs -r docker rmi -f

# Remove all volumes
echo "📦 Removing volumes..."
docker volume ls -q | xargs -r docker volume rm

# Prune everything else
echo "🧼 Pruning system (networks, cache, etc.)..."
docker system prune -a --volumes -f

echo "✅ Docker environment fully cleaned."
