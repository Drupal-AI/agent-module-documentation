#!/usr/bin/env bash
# Introspection SETUP: configure Menu Entity Index to track the 'main' menu and the
# 'node' entity type, so an inspecting agent can read back the tracking config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("menu_entity_index.configuration");
  $c->set("all_menus", FALSE)
    ->set("menus", ["main" => "main"])
    ->set("entity_types", ["node" => "node"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu_entity_index tracks menus=[main], entity_types=[node]"
