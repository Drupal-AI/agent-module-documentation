#!/usr/bin/env bash
# Execution CLEANUP: uninstall and delete the jqonce_addonce module so core/drupal.debounce is
# back to its stock dependencies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqonce_addonce -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/jqonce_addonce
drush cr >/dev/null 2>&1
echo "cleanup: jqonce_addonce module uninstalled and removed"
