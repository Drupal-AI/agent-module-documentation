#!/usr/bin/env bash
# Execution RESET: make sure no jqd_task module exists. Uninstall it FIRST (an enabled module
# whose directory is gone makes the kernel fatal), then delete the directory, so verify FAILS
# on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqd_task -y >/dev/null 2>&1
rm -rf web/modules/custom/jqd_task
drush cr >/dev/null 2>&1
echo "reset: jqd_task uninstalled and removed"
