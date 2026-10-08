#!/usr/bin/env bash
# Introspection CLEANUP: restore orientation to horizontal and clear button_style (shipped
# default leaves it unset). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shariff.settings")
    ->set("shariff_orientation", "horizontal")
    ->clear("shariff_button_style")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: shariff.settings orientation restored, button_style cleared"
