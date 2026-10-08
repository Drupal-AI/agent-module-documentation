#!/usr/bin/env bash
# Execution CLEANUP: re-enable plupload_test to restore the campaign baseline (it ships
# enabled for these docs). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx plupload_test; then
  drush en plupload_test -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "cleanup: plupload_test enabled"
