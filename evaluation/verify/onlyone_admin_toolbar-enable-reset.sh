#!/usr/bin/env bash
# Execution RESET: uninstall onlyone_admin_toolbar so verify FAILS until the agent enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu onlyone_admin_toolbar -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: onlyone_admin_toolbar uninstalled"
