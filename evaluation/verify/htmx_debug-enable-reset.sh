#!/usr/bin/env bash
# Execution RESET: ensure htmx_debug is DISABLED (baseline) so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu htmx_debug -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: htmx_debug uninstalled"
