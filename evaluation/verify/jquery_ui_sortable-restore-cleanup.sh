#!/usr/bin/env bash
# Execution CLEANUP: re-enable jquery_ui_sortable (baseline state on this site).
set -uo pipefail
cd /var/www/html
drush pm:install jquery_ui_sortable -y >/dev/null 2>&1 || drush en jquery_ui_sortable -y >/dev/null 2>&1
echo "cleanup: jquery_ui_sortable enabled (baseline)"
