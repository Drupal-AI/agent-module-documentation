#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("page_cache_query_ignore.settings")
    ->set("query_parameters", [])
    ->set("ignore_action", "exclude")
    ->set("ignore_redirects", FALSE)
    ->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: page_cache_query_ignore.settings restored to defaults"
