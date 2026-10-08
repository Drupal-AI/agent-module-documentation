#!/usr/bin/env bash
# Execution RESET: uninstall gin_everywhere so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx gin_everywhere && drush pmu gin_everywhere -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gin_everywhere uninstalled"
