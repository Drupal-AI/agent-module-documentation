#!/usr/bin/env bash
# Execution RESET: remove any previously built jqonce_addonce module so core/drupal.debounce
# does NOT depend on core/jquery.once; verify must FAIL here. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqonce_addonce -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/jqonce_addonce
drush cr >/dev/null 2>&1
echo "reset: jqonce_addonce module uninstalled and removed"
