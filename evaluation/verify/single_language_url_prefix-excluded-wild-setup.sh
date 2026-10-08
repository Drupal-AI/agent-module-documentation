#!/usr/bin/env bash
# Introspection SETUP: set excluded_paths to a wildcard set so an agent can read which paths are
# excluded from the language prefix. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("single_language_url_prefix.settings")
    ->set("excluded_paths", "/reports/*")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: excluded_paths = /reports/*"
