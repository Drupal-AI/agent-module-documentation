#!/usr/bin/env bash
# Execution CLEANUP: same as reset — uninstall (pmu) then remove the module directory. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx plupload_demo_eval; then
  drush pmu plupload_demo_eval -y >/dev/null 2>&1
fi
rm -rf /var/www/html/web/modules/custom/plupload_demo_eval
drush cr >/dev/null 2>&1
echo "cleanup: plupload_demo_eval uninstalled and removed"
