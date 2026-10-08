#!/usr/bin/env bash
# Introspection SETUP: create role menu_select_searcher and grant it 'use menu select search'
# so an inspecting agent can find which role holds the permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create menu_select_searcher 'Menu Select Searcher' >/dev/null 2>&1 || true
drush role:perm:add menu_select_searcher 'use menu select search' >/dev/null 2>&1 || true
echo "setup: role menu_select_searcher has 'use menu select search'"
