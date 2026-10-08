#!/usr/bin/env bash
# Introspection SETUP: set shariff.settings orientation=vertical and button_style=icon, so an
# agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shariff.settings")
    ->set("shariff_orientation", "vertical")
    ->set("shariff_button_style", "icon")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: shariff.settings orientation=vertical button_style=icon"
