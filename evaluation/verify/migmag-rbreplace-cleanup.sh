#!/usr/bin/env bash
# CLEANUP/RESET to baseline: uninstall migmag_rollbackable_replace (baseline = disabled).
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_rollbackable_replace && drush pmu migmag_rollbackable_replace -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migmag_rollbackable_replace uninstalled (baseline)"
