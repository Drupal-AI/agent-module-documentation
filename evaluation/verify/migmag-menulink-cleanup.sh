#!/usr/bin/env bash
# CLEANUP/RESET to baseline: uninstall migmag_menu_link_migrate (baseline = disabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_menu_link_migrate && drush pmu migmag_menu_link_migrate -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migmag_menu_link_migrate uninstalled (baseline)"
