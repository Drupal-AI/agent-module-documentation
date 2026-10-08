#!/usr/bin/env bash
# Execution CLEANUP: uninstall and delete the custom enhancer module built for this case. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu ebe_zoom_enhancer -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/ebe_zoom_enhancer
drush cr >/dev/null 2>&1
echo "cleanup: ebe_zoom_enhancer module uninstalled and removed"
