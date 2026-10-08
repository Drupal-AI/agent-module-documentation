#!/usr/bin/env bash
# Execution RESET: remove any previously built jqonce_legacy module so its library does not
# exist; verify must FAIL here. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqonce_legacy -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/jqonce_legacy
drush cr >/dev/null 2>&1
echo "reset: jqonce_legacy module uninstalled and removed"
