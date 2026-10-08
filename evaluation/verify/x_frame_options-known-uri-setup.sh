#!/usr/bin/env bash
# Introspection SETUP: set directive ALLOW-FROM with a known allow-from-uri. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("x_frame_options_configuration.settings")->set("x_frame_options_configuration.directive", "ALLOW-FROM")->set("x_frame_options_configuration.allow-from-uri", "https://xfo-partner.example.com/")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: directive=ALLOW-FROM uri=https://xfo-partner.example.com/"
