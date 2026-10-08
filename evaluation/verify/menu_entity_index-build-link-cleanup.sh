#!/usr/bin/env bash
# Execution CLEANUP: remove the hard-case node + any menu link to it and reset tracking. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title" => "MEI Hard Menu Link"]) as $l) { $l->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "MEI Hard Target"]) as $n) { $n->delete(); }
  $c = \Drupal::configFactory()->getEditable("menu_entity_index.configuration");
  $c->set("all_menus", FALSE)->set("menus", [])->set("entity_types", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu_entity_index hard fixture removed, tracking reset"
