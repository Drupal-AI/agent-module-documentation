#!/usr/bin/env bash
# Introspection CLEANUP: delete role menu_select_searcher. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete menu_select_searcher >/dev/null 2>&1 || true
echo "cleanup: role menu_select_searcher removed"
