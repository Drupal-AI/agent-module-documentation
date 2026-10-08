#!/usr/bin/env bash
# Introspection SETUP: force menu_select search OFF (search_enabled=false) so an inspecting
# agent can read back the live value. Baseline default is true. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set menu_select.settings search_enabled 0 -y >/dev/null 2>&1
echo "setup: menu_select.settings search_enabled=false"
