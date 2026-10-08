#!/usr/bin/env bash
# Execution CLEANUP: uninstall the host module FIRST, then remove its directory. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu preprocess_yaml_host -y >/dev/null 2>&1
rm -rf web/modules/custom/preprocess_yaml_host
drush cr >/dev/null 2>&1
echo "cleanup: module preprocess_yaml_host uninstalled and directory removed"
