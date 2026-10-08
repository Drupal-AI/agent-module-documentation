#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default (search_enabled=true). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set menu_select.settings search_enabled 1 -y >/dev/null 2>&1
echo "cleanup: menu_select.settings search_enabled=true (baseline)"
