#!/usr/bin/env bash
# Introspection SETUP: configure Gin Toolbar Custom Menu to also keep the original administration
# menu (keep_admin_menu = 1), so an agent can read that global setting.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gin_toolbar_custom_menu.settings")
    ->set("keep_admin_menu", 1)
    ->set("settings", [["menu"=>"main","role"=>["authenticated"],"excluded_role"=>[],"icons"=>[],"admin_menu"=>"use_global","actions"=>[]]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gin_toolbar_custom_menu.settings keep_admin_menu=1"
