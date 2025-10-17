#!/bin/bash
set -e

echo "🧹 Cleaning up XRDP PID files"
rm -f /var/run/xrdp/xrdp-sesman.pid
rm -f /var/run/xrdp/xrdp.pid

echo "🚀 Starting XRDP services"
/usr/sbin/xrdp-sesman &
/usr/sbin/xrdp
