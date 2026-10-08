#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (htmx_debug DISABLED). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu htmx_debug -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: htmx_debug uninstalled (baseline)"
