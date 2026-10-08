#!/usr/bin/env bash
# HARD execution reset (shared by the -layman and -expert flood-protection build cases):
# return searchstax.settings flood_protection to install defaults (disabled, limit 15/10s) so
# the build task starts from a clean, failing state.
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
echo "reset: searchstax flood_protection disabled, limits back to install defaults"
