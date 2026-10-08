#!/usr/bin/env bash
# Execution RESET: write gin_toolbar_custom_menu.settings with keep_admin_menu = 0 (and one rule),
# so verify FAILS until the agent enables keeping the administration menu.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gin_toolbar_custom_menu.settings")
    ->set("keep_admin_menu", 0)
    ->set("settings", [["menu"=>"main","role"=>["authenticated"],"excluded_role"=>[],"icons"=>[],"admin_menu"=>"use_global","actions"=>[]]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gin_toolbar_custom_menu.settings keep_admin_menu=0"
