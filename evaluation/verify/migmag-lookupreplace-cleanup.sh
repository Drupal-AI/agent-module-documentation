#!/usr/bin/env bash
# CLEANUP/RESET to baseline: uninstall migmag_process_lookup_replace (baseline = disabled).
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_process_lookup_replace && drush pmu migmag_process_lookup_replace -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migmag_process_lookup_replace uninstalled (baseline)"
