#!/usr/bin/env bash
# Execution CLEANUP: ensure pcb_redis uninstalled (baseline). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu pcb_redis -y >/dev/null 2>&1 || true
echo "cleanup: pcb_redis uninstalled"
