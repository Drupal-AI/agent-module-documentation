#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore searchstax.settings flood_protection to install defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("searchstax.settings")
    ->set("flood_protection.enabled", FALSE)
    ->set("flood_protection.search_limit", 15)
    ->set("flood_protection.search_window", 10)
    ->set("flood_protection.update_limit", 50)
    ->set("flood_protection.update_window", 60)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: searchstax flood_protection restored to install defaults"
