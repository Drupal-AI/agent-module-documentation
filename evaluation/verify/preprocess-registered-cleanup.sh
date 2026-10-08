#!/usr/bin/env bash
# Introspection CLEANUP: uninstall the host module FIRST, then remove its directory (never
# leave an enabled module with a missing dir). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu preprocess_med_host -y >/dev/null 2>&1
rm -rf web/modules/custom/preprocess_med_host
drush cr >/dev/null 2>&1
echo "cleanup: module preprocess_med_host uninstalled and directory removed"
