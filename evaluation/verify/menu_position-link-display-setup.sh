#!/usr/bin/env bash
# Introspection SETUP: set menu_position.settings:link_display to 'child' (the shipped default
# is 'parent'), so the agent must read the live setting instead of reciting the default.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set menu_position.settings link_display child -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush config:get menu_position.settings link_display 2>/dev/null
echo "setup: menu_position.settings link_display=child"
