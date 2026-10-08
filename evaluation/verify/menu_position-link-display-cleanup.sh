#!/usr/bin/env bash
# Introspection CLEANUP: restore menu_position.settings:link_display to the shipped default
# 'parent'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set menu_position.settings link_display parent -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush config:get menu_position.settings link_display 2>/dev/null
echo "cleanup: menu_position.settings link_display=parent (default)"
