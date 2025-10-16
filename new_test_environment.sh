#!/bin/bash

# Usage: ./new_test_environment.sh <new_container_name> [<host_port>]
# Example: ./new_test_environment.sh trixie-dev1 3390

# Defaults
BASE_IMAGE="debian-trixie-xfce-xrdp"
DEFAULT_PORT=3389

# Input
NEW_NAME="$1"
HOST_PORT="${2:-$DEFAULT_PORT}"

if [ -z "$NEW_NAME" ]; then
  echo "❌ Please provide a name for the new container."
  echo "Usage: ./new_test_environment.sh <new_container_name> [<host_port>]"
  exit 1
fi

echo "🚀 Creating new test environment: $NEW_NAME"
echo "🔌 Mapping host port $HOST_PORT to container port 3389"

# Run new container
docker run -d -p "$HOST_PORT":3389 --name "$NEW_NAME" "$BASE_IMAGE"

echo "✅ Container '$NEW_NAME' is running."
echo "🖥️ Connect via RDP to localhost:$HOST_PORT (user: docker / pass: docker)"
