#!/usr/bin/env bash
# Execution RESET: make sure the custom module ginlb_no_toolbar does NOT exist and is NOT
# enabled, so verify FAILS until the agent writes it. Uninstalls BEFORE deleting the directory
# (an enabled module whose directory is gone fatals the kernel on terminate). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu ginlb_no_toolbar -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/ginlb_no_toolbar
drush cr >/dev/null 2>&1
echo "reset: ginlb_no_toolbar uninstalled and removed"
