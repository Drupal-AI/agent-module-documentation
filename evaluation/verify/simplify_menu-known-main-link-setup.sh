#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN menu link to the 'main' menu so an inspecting agent can
# read it back through simplify_menu's service (simplify_menu.menu_items::getMenuTree('main')).
# Creates one link: title "SM Eval Portal" -> internal:/node. A full cache rebuild afterwards
# makes the new link visible to a plain read (Drupal caches the menu tree persistently).
# Idempotent (deletes any prior copy first). Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->loadByProperties(["title" => "SM Eval Portal"]) as $old) { $old->delete(); }
  $l = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
    "title" => "SM Eval Portal",
    "link" => ["uri" => "internal:/node"],
    "menu_name" => "main",
    "weight" => -50,
  ]);
  $l->save();
  \Drupal::service("plugin.manager.menu.link")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: added main-menu link 'SM Eval Portal' -> /node"
