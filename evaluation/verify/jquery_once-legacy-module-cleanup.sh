#!/usr/bin/env bash
# Execution CLEANUP: uninstall and delete the jqonce_legacy module built for this case. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqonce_legacy -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/jqonce_legacy
drush cr >/dev/null 2>&1
echo "cleanup: jqonce_legacy module uninstalled and removed"
