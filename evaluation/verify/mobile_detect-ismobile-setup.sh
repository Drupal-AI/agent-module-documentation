#!/usr/bin/env bash
# Introspection SETUP: turn ON the experimental mobile_detect_is_mobile page cache context.
# (Set via php:eval — `drush config:set ... true/false` mis-casts booleans.) Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("mobile_detect.settings")->set("mobile_detect_is_mobile", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mobile_detect.settings mobile_detect_is_mobile = true"
