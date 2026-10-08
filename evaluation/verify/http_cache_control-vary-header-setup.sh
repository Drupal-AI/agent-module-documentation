#!/usr/bin/env bash
# Introspection setup: set a known Vary value.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("http_cache_control.settings")
    ->set("cache.http.vary", "Accept-Language")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cache.http.vary = Accept-Language"
