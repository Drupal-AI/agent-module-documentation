#!/usr/bin/env bash
# Introspection CLEANUP: remove the fixture menu link + node and reset tracking config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["menu_link_content" => "MEI Introspect Menu Link", "node" => "MEI Introspect Target"] as $type => $title) {
    foreach (\Drupal::entityTypeManager()->getStorage($type)->loadByProperties(["title" => $title]) as $e) {
      $e->delete();
    }
  }
  $c = \Drupal::configFactory()->getEditable("menu_entity_index.configuration");
  $c->set("all_menus", FALSE)->set("menus", [])->set("entity_types", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu_entity_index fixture removed, tracking reset"
