#!/usr/bin/env bash
# Introspection SETUP: write a Gin Toolbar Custom Menu rule mapping the 'main' menu to the
# authenticated role, so an agent can read which menu is configured. Baseline: config absent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gin_toolbar_custom_menu.settings")
    ->set("keep_admin_menu", 0)
    ->set("settings", [["menu"=>"main","role"=>["authenticated"],"excluded_role"=>[],"icons"=>[],"admin_menu"=>"use_global","actions"=>[]]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gin_toolbar_custom_menu.settings rule menu=main role=authenticated"
