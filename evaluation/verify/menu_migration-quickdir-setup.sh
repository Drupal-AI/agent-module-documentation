#!/usr/bin/env bash
# Introspection SETUP: set the Quick Action Settings (menu_migration.quick_export) to a known
# format + directory so an agent can read back what the quick drush commands use. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset menu_migration.quick_export format yaml -y >/dev/null 2>&1
drush cset menu_migration.quick_export export_path '../config/menu_migration/mm_mig_quickdir' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: quick_export format=yaml export_path=../config/menu_migration/mm_mig_quickdir"
