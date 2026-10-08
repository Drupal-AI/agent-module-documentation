#!/usr/bin/env bash
# Execution RESET: remove the trcr_backend class file/dir so verify FAILS until the agent writes a
# TracerInterface backend class. The module is never enabled (no orphaned-module risk). Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/trcr_backend
echo "reset: web/modules/custom/trcr_backend removed"
