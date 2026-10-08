#!/usr/bin/env bash
# Introspection setup: set a known shared-cache max age so the agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("http_cache_control.settings")
    ->set("cache.http.s_maxage", 86400)
    ->set("cache.http.stale_while_revalidate", 60)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: s_maxage=86400, stale_while_revalidate=60"
