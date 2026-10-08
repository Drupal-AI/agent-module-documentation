#!/usr/bin/env bash
# Introspection SETUP: set a known menu_manipulator.settings menu_link_icon_list value so an
# inspecting agent can read back which icons are available. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("menu_manipulator.settings")
    ->set("menu_link_icon_list", "star,heart,home")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu_manipulator menu_link_icon_list = star,heart,home"
