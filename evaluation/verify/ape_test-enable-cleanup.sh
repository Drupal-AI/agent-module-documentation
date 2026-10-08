#!/usr/bin/env bash
# Execution CLEANUP: uninstall ape_test (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu ape_test -y >/dev/null 2>&1 || true
echo "cleanup: ape_test uninstalled"
