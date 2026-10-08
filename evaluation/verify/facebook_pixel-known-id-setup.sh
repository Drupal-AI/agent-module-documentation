#!/usr/bin/env bash
# Introspection SETUP: write a distinctive Facebook Pixel ID into facebook_pixel.settings so
# the agent has to read the live configuration to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")
    ->set("facebook_id", "111222333444555")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facebook_pixel.settings facebook_id=111222333444555"
