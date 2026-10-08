#!/usr/bin/env bash
# Execution RESET: ensure pcb_redis is UNINSTALLED so the permanent redis service is absent and
# verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu pcb_redis -y >/dev/null 2>&1 || true
echo "reset: pcb_redis uninstalled (service absent)"
