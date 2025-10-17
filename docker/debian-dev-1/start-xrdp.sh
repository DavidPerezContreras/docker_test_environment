#!/bin/bash
set -e

echo "🧹 Cleaning up XRDP PID files"
rm -f /var/run/xrdp/xrdp-sesman.pid
rm -f /var/run/xrdp/xrdp.pid


/usr/sbin/xrdp-sesman &
/usr/sbin/xrdp
echo "🚀 XRDP and sesman started"