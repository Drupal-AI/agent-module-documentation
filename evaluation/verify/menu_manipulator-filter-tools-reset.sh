#!/usr/bin/env bash
# Execution RESET: set menu_manipulator.settings language list to the shipped default (tools
# NOT filtered), so verify FAILS until the agent enables language filtering on the tools menu.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("menu_manipulator.settings")
    ->set("preprocess_menus_language", TRUE)
    ->set("preprocess_menus_language_list", ["footer" => "footer", "main" => "main", "account" => "", "admin" => "", "links" => "", "tools" => ""])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu_manipulator tools menu NOT language-filtered"
