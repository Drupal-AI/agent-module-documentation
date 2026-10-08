#!/usr/bin/env bash
# Introspection SETUP: set single_language_url_prefix.settings excluded_paths to a known value so an
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("single_language_url_prefix.settings")
    ->set("excluded_paths", "/slup-secret\n/slup-secret/*")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: excluded_paths = /slup-secret and /slup-secret/*"
