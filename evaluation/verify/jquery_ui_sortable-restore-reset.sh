#!/usr/bin/env bash
# Execution RESET: uninstall jquery_ui_sortable so the jquery_ui_sortable/sortable library no
# longer resolves (verify FAILS until the agent re-enables the module). Idempotent.
set -uo pipefail
cd /var/www/html
drush pm:uninstall jquery_ui_sortable -y >/dev/null 2>&1 || drush pmu jquery_ui_sortable -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jquery_ui_sortable uninstalled"
