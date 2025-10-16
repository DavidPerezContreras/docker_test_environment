#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
source "$SCRIPT_DIR/workspace.sh"

ENV_NAME="$1"
ENV_DIR="$WORKSPACE_ROOT/docker/$ENV_NAME"
COMPOSE_FILE="$ENV_DIR/docker-compose.yaml"

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
  echo "This will run docker-compose up inside docker/$ENV_NAME"
  exit 0
fi

echo "🔍 Looking for docker-compose.yaml in: $ENV_DIR"

if [[ ! -f "$COMPOSE_FILE" ]]; then
  echo "❌ Environment '$ENV_NAME' not found or missing docker-compose.yaml."
  exit 1
fi

echo "🚀 Starting environment '$ENV_NAME'..."
cd "$ENV_DIR"
docker compose -p "$ENV_NAME" up
