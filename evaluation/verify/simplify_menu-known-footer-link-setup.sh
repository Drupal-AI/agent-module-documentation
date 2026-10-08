#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN menu link to the 'footer' menu (NOT main) so an inspecting
# agent must call simplify_menu's service against the correct menu id to find it.
# Creates: title "SM Eval Support" -> internal:/node. A full cache rebuild afterwards makes the
# new link visible to a plain read (Drupal caches the menu tree persistently).
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->loadByProperties(["title" => "SM Eval Support"]) as $old) { $old->delete(); }
  $l = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
    "title" => "SM Eval Support",
    "link" => ["uri" => "internal:/node"],
    "menu_name" => "footer",
    "weight" => -50,
  ]);
  $l->save();
  \Drupal::service("plugin.manager.menu.link")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: added footer-menu link 'SM Eval Support' -> /node"
