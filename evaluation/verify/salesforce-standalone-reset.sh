#!/usr/bin/env bash
# Execution RESET: set standalone=false so verify FAILS until agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("standalone",false)->save();' >/dev/null 2>&1
echo "reset: standalone=false"
