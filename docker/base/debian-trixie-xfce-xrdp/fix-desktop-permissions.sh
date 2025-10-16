#!/bin/bash

echo "🔧 Fixing ownership of Desktop (excluding Development)..."

sudo find /home/docker/Desktop \
  -path /home/docker/Desktop/Development -prune -o \
  -exec chown docker:docker {} +

echo "✅ Desktop ownership fixed."
