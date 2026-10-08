#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped Quick Action Settings defaults (config/install). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset menu_migration.quick_export format json -y >/dev/null 2>&1
drush cset menu_migration.quick_export export_path '../config/menu_migration/quick-export' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: quick_export restored to format=json export_path=../config/menu_migration/quick-export"
