#!/usr/bin/env bash
# Introspection SETUP: switch to include-only mode with a distinctive param and redirect
# ignoring ON, so the agent must inspect live config to report the action. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("page_cache_query_ignore.settings")
    ->set("query_parameters", ["pcqi_only"])
    ->set("ignore_action", "include")
    ->set("ignore_redirects", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ignore_action=include query_parameters=[pcqi_only] ignore_redirects=TRUE"
