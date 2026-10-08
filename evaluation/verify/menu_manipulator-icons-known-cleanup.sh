#!/usr/bin/env bash
# Introspection CLEANUP: clear the menu_link_icon_list value set by setup (shipped default is
# unset). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("menu_manipulator.settings")->set("menu_link_icon_list", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu_manipulator menu_link_icon_list cleared"
