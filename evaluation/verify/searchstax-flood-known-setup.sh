#!/usr/bin/env bash
# MEDIUM introspection setup: turn on SearchStax flood protection with known limits so the
# agent can be asked to read them back from live config. Restored by the -cleanup script.
# No SearchStax network access required — this only touches the searchstax.settings config.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("searchstax.settings")
    ->set("flood_protection.enabled", TRUE)
    ->set("flood_protection.search_limit", 7)
    ->set("flood_protection.search_window", 45)
    ->set("flood_protection.update_limit", 50)
    ->set("flood_protection.update_window", 60)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: searchstax flood_protection enabled, search_limit=7, search_window=45"
