#!/usr/bin/env bash
# Introspection SETUP: set the active responsive_menus style to mean_menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset responsive_menus.configuration style mean_menu -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: responsive_menus.configuration style = mean_menu"
