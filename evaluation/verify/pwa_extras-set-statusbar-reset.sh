#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore color_select to default so verify FAILS until agent sets
# black_translucent. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_extras.settings.apple")->set("color_select","default")->save();' >/dev/null 2>&1
echo "reset: pwa_extras.settings.apple color_select=default"
