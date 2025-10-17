#!/bin/bash

# Set password for docker user if provided
if [ -n "$DOCKER_PASSWORD" ]; then
  echo "docker:$DOCKER_PASSWORD" | chpasswd
  echo "✅ Password set for user 'docker'"
fi

# Set password for root user if provided
if [ -n "$ROOT_PASSWORD" ]; then
  echo "root:$ROOT_PASSWORD" | chpasswd
  echo "✅ Password set for user 'root'"
fi
