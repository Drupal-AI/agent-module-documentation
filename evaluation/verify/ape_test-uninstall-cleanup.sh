#!/usr/bin/env bash
# Execution CLEANUP: ensure ape_test uninstalled (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu ape_test -y >/dev/null 2>&1 || true
echo "cleanup: ape_test uninstalled"
