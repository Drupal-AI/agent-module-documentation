#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (timeout=1440, testmode=TRUE).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_abandoned_carts.settings")->set("timeout", 1440)->set("testmode", TRUE)->save();' >/dev/null 2>&1
echo "cleanup: timeout=1440 testmode=TRUE"
