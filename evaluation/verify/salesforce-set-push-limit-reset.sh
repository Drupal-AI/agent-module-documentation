#!/usr/bin/env bash
# Execution RESET: set global_push_limit to default 100000 so verify FAILS until agent sets 500. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("global_push_limit",100000)->save();' >/dev/null 2>&1
echo "reset: global_push_limit=100000"
