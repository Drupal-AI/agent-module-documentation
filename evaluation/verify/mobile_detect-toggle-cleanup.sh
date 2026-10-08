#!/usr/bin/env bash
# Execution CLEANUP: restore default (off). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("mobile_detect.settings")->set("mobile_detect_is_mobile", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mobile_detect_is_mobile = false"
