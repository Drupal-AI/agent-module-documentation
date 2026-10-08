#!/usr/bin/env bash
# Execution RESET: remove the trcr_recorder class file/dir so verify FAILS until the agent writes
# a working TracerInterface backend that actually records spans. Never enabled. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/trcr_recorder
echo "reset: web/modules/custom/trcr_recorder removed"
