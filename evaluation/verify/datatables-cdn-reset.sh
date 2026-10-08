#!/usr/bin/env bash
# Execution RESET/CLEANUP: set use_cdn=false so verify FAILS until the agent enables CDN. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("datatables.settings")->set("use_cdn", FALSE)->save();' >/dev/null 2>&1
echo "reset: datatables.settings use_cdn=false"
