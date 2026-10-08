#!/usr/bin/env bash
# Execution RESET: baseline for the go-live task: timeout=1440, testmode=TRUE (default).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_abandoned_carts.settings")->set("timeout", 1440)->set("testmode", TRUE)->save();' >/dev/null 2>&1
echo "reset: timeout=1440 testmode=TRUE"
