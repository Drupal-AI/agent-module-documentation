#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors.config")->set("items_per_page", 10)->save();' >/dev/null 2>&1
echo "cleanup: visitors.config items_per_page=10"
