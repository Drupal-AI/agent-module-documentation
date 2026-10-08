#!/usr/bin/env bash
# Execution CLEANUP: same as reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall facebook_pixel_eval_alter -y >/dev/null 2>&1
rm -rf web/modules/custom/facebook_pixel_eval_alter
drush cr >/dev/null 2>&1
echo "cleanup: facebook_pixel_eval_alter removed"
