#!/usr/bin/env bash
# Execution RESET: force the Menu settings tab weight back to its default (3) so verify FAILS until
# the agent changes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset vertical_tabs_config.order vertical_tabs_config_menu 3 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vertical_tabs_config_menu=3 (default)"
