#!/usr/bin/env bash
# Execution CLEANUP: uninstall onlyone_admin_toolbar to restore baseline (disabled).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu onlyone_admin_toolbar -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: onlyone_admin_toolbar uninstalled"
