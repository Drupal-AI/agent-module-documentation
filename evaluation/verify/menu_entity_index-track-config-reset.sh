#!/usr/bin/env bash
# Execution RESET: clear Menu Entity Index tracking config to shipped defaults so verify
# FAILS until the agent configures tracking. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("menu_entity_index.configuration");
  $c->set("all_menus", FALSE)->set("menus", [])->set("entity_types", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu_entity_index tracking config cleared"
