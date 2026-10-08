#!/usr/bin/env bash
# Introspection SETUP: enable a custom Media Thumbnails background color (#123456), so the agent
# can inspect the live media_thumbnails.settings and report the configured color. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_thumbnails.settings")
    ->set("bgcolor_active", TRUE)->set("bgcolor_value", "#123456")->save();
' >/dev/null 2>&1
echo "setup: media_thumbnails.settings bgcolor_active=true bgcolor_value=#123456"
