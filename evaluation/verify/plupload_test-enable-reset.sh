#!/usr/bin/env bash
# Execution RESET: uninstall the plupload_test demo module so its /plupload-test route is gone
# and verify FAILS until it is re-enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx plupload_test; then
  drush pmu plupload_test -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "reset: plupload_test uninstalled"
