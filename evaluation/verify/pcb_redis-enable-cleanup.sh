#!/usr/bin/env bash
# Execution CLEANUP: uninstall pcb_redis to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu pcb_redis -y >/dev/null 2>&1 || true
echo "cleanup: pcb_redis uninstalled"
