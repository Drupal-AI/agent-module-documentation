#!/usr/bin/env bash
# Execution CLEANUP: uninstall the ginlb_no_toolbar module BEFORE removing its directory, then
# delete it. Leaving an enabled module with a missing directory fatals the kernel on terminate.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu ginlb_no_toolbar -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/ginlb_no_toolbar
drush cr >/dev/null 2>&1
echo "cleanup: ginlb_no_toolbar uninstalled and removed"
