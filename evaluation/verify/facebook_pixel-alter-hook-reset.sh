#!/usr/bin/env bash
# Execution RESET for "implement hook_facebook_pixel_event_data_alter()": uninstall and
# delete any facebook_pixel_eval_alter module, so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall facebook_pixel_eval_alter -y >/dev/null 2>&1
rm -rf web/modules/custom/facebook_pixel_eval_alter
drush cr >/dev/null 2>&1
echo "reset: facebook_pixel_eval_alter removed"
