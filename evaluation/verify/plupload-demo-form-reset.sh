#!/usr/bin/env bash
# Execution RESET for the "build a form module using the plupload element" case.
# Uninstalls and removes any prior attempt so verify FAILS on a clean slate.
# IMPORTANT: pmu (uninstall) BEFORE removing the directory to avoid a kernel fatal.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx plupload_demo_eval; then
  drush pmu plupload_demo_eval -y >/dev/null 2>&1
fi
rm -rf /var/www/html/web/modules/custom/plupload_demo_eval
drush cr >/dev/null 2>&1
echo "reset: plupload_demo_eval uninstalled and removed"
