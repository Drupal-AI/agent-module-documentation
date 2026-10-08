#!/usr/bin/env bash
# Introspection CLEANUP: restore menu_manipulator.settings language filtering to the shipped
# default list (footer + main active). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("menu_manipulator.settings")
    ->set("preprocess_menus_language", TRUE)
    ->set("preprocess_menus_language_list", ["footer" => "footer", "main" => "main", "account" => "", "admin" => "", "links" => "", "tools" => ""])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu_manipulator language list restored to default (footer, main)"
