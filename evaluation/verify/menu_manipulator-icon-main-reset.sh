#!/usr/bin/env bash
# Execution RESET: set menu_manipulator.settings icon list to the shipped default (main menu
# NOT icon-enabled), so verify FAILS until the agent enables icons for the main menu.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("menu_manipulator.settings")
    ->set("preprocess_menus_icon", TRUE)
    ->set("preprocess_menus_icon_list", ["account" => "", "admin" => "", "devel" => "", "footer" => "", "main" => "", "tools" => ""])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu_manipulator main menu NOT icon-enabled"
