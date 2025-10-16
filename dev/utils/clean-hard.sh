#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
source "$SCRIPT_DIR/workspace.sh"

echo "🧹 Starting full Docker cleanup..."

docker ps -aq | xargs -r docker stop
docker ps -aq | xargs -r docker rm
docker images -q | xargs -r docker rmi -f
docker volume ls -q | xargs -r docker volume rm
docker system prune -a --volumes -f

echo "✅ Docker environment fully cleaned."
