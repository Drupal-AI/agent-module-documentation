#!/usr/bin/env bash
# Introspection CLEANUP: restore single_language_url_prefix.settings excluded_paths to its shipped
# default (empty string). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("single_language_url_prefix.settings")->set("excluded_paths", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: excluded_paths restored to empty"
