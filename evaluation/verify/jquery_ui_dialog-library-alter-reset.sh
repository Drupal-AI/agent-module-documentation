#!/usr/bin/env bash
# Execution RESET: make sure no jqd_alter module exists so the jquery_ui_dialog/dialog library
# reports its stock version and verify FAILS. Uninstall BEFORE deleting the directory.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqd_alter -y >/dev/null 2>&1
rm -rf web/modules/custom/jqd_alter
drush cr >/dev/null 2>&1
echo "reset: jqd_alter uninstalled and removed; jquery_ui_dialog/dialog back to stock version"
