#!/usr/bin/env bash
# Execution CLEANUP: uninstall and remove the dhv_login_override module (pmu BEFORE rm).
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx dhv_login_override; then
  drush pmu dhv_login_override -y >/dev/null 2>&1 || true
fi
rm -rf web/modules/custom/dhv_login_override
drush cr >/dev/null 2>&1
echo "cleanup: dhv_login_override removed"
