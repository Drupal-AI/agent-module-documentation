#!/usr/bin/env bash
# Execution RESET: force placeholder_text back to the default 'search' so verify FAILS until
# the agent changes it to 'Type to search'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("better_search.settings")->set("placeholder_text", "search")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: better_search.settings placeholder_text='search'"
