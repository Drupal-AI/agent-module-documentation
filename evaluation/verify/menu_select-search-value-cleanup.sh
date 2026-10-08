#!/usr/bin/env bash
# Introspection CLEANUP: restore menu_select shipped default (search_enabled=true). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set menu_select.settings search_enabled 1 -y >/dev/null 2>&1
echo "cleanup: menu_select.settings search_enabled=true (baseline)"
