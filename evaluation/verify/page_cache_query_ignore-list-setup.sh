#!/usr/bin/env bash
# Introspection SETUP: write a known ignored-parameter list to the live config so an agent
# can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("page_cache_query_ignore.settings")
    ->set("query_parameters", ["pcqi_known_a", "pcqi_known_b"])
    ->set("ignore_action", "exclude")
    ->set("ignore_redirects", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: page_cache_query_ignore.settings query_parameters=[pcqi_known_a,pcqi_known_b] action=exclude"
