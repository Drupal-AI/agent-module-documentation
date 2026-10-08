#!/usr/bin/env bash
# Execution RESET: restore shipped defaults so verify FAILS until the agent switches to
# include-only mode keeping 'page'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("page_cache_query_ignore.settings")
    ->set("query_parameters", [])
    ->set("ignore_action", "exclude")
    ->set("ignore_redirects", FALSE)
    ->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: page_cache_query_ignore.settings defaults (action=exclude, empty list)"
