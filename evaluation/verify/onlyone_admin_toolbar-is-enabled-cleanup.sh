#!/usr/bin/env bash
# Introspection CLEANUP: uninstall onlyone_admin_toolbar to restore baseline (disabled).
# admin_toolbar_tools is intentionally left as-is. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu onlyone_admin_toolbar -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: onlyone_admin_toolbar uninstalled"
