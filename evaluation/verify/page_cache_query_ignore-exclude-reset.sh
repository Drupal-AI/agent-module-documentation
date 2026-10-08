#!/usr/bin/env bash
# Execution RESET: restore shipped defaults (empty list, exclude) so verify FAILS until the
# agent adds the tracking params. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("page_cache_query_ignore.settings")
    ->set("query_parameters", [])
    ->set("ignore_action", "exclude")
    ->set("ignore_redirects", FALSE)
    ->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: page_cache_query_ignore.settings query_parameters empty, action=exclude"
