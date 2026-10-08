#!/usr/bin/env bash
# Execution RESET: force visitors.config items_per_page to 10 so verify FAILS until agent sets 25.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors.config")->set("items_per_page", 10)->save();' >/dev/null 2>&1
echo "reset: visitors.config items_per_page=10"
