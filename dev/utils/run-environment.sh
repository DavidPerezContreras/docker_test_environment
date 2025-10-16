#!/bin/bash

# Usage: ./run-environment.sh <environment-name>

ENV_NAME="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_DIR="$SCRIPT_DIR/../../docker/$ENV_NAME"
COMPOSE_FILE="$ENV_DIR/docker-compose.yaml"

# Help
if [[ "$ENV_NAME" == "-h" || "$ENV_NAME" == "--help" || -z "$ENV_NAME" ]]; then
  echo "🚀 Usage:"
  echo "  $0 <environment-name>"
  echo
  echo "📦 Arguments:"
  echo "  <environment-name>  Name of the folder inside docker/ to run"
  echo
  echo "📁 Example:"
  echo "  $0 debian-dev-2"
  echo
  echo "This will run docker-compose up inside docker/debian-dev-2"
  exit 0
fi

# Validate
if [[ ! -f "$COMPOSE_FILE" ]]; then
  echo "❌ Environment '$ENV_NAME' not found or missing docker-compose.yaml."
  exit 1
fi

# Run
echo "🚀 Starting environment '$ENV_NAME'..."
cd "$ENV_DIR"
docker compose -p "$ENV_NAME" up
