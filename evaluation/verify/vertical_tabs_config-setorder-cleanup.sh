#!/usr/bin/env bash
# Execution CLEANUP: restore the Menu settings tab weight to default (3). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset vertical_tabs_config.order vertical_tabs_config_menu 3 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vertical_tabs_config_menu restored to 3"
