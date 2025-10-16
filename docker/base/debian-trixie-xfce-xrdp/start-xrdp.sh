#!/bin/bash
set -e

# Clean up stale PID files
rm -f /var/run/xrdp/xrdp-sesman.pid
rm -f /var/run/xrdp/xrdp.pid

# Start XRDP services
/usr/sbin/xrdp-sesman
/usr/sbin/xrdp

# Keep container alive
tail -f /dev/null
