#!/usr/bin/env bash
# Introspection SETUP: set menu_manipulator.settings so that ONLY the 'account' menu is
# language-filtered (a distinctive, non-default value), so an inspecting agent can read back
# which menu is filtered. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("menu_manipulator.settings")
    ->set("preprocess_menus_language", TRUE)
    ->set("preprocess_menus_language_list", ["footer" => "", "main" => "", "account" => "account", "admin" => "", "links" => "", "tools" => ""])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu_manipulator language filtering limited to the account menu"
