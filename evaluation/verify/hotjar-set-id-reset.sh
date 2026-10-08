#!/usr/bin/env bash
# Execution RESET: clear the Hotjar ID so nothing is tracked (verify FAILS until agent sets it).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hotjar.settings")->set("account","")->save();' >/dev/null 2>&1
echo "reset: hotjar.settings account='' (no ID configured)"
