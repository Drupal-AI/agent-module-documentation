#!/usr/bin/env bash
# Introspection SETUP: enable the Color config entity type (colorapi.settings.enable_color_entity=true)
# so an inspecting agent can read that it is on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("colorapi.settings")->set("enable_color_entity", 1)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: colorapi.settings.enable_color_entity = 1"
