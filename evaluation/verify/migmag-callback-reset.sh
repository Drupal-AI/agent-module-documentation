#!/usr/bin/env bash
# CLEANUP/RESET to baseline: uninstall migmag_callback_upgrade (baseline = disabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_callback_upgrade && drush pmu migmag_callback_upgrade -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migmag_callback_upgrade uninstalled (baseline)"
