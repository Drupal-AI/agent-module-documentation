#!/usr/bin/env bash
# Execution RESET/CLEANUP: force style back to the shipped default (responsive_menus_simple), so
# verify FAILS until the agent switches it to mean_menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset responsive_menus.configuration style responsive_menus_simple -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: responsive_menus.configuration style = responsive_menus_simple"
