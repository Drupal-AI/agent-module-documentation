#!/usr/bin/env bash
# Introspection SETUP: set the X-Frame-Options directive to SAMEORIGIN. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("x_frame_options_configuration.settings")->set("x_frame_options_configuration.directive", "SAMEORIGIN")->set("x_frame_options_configuration.allow-from-uri", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: directive=SAMEORIGIN"
