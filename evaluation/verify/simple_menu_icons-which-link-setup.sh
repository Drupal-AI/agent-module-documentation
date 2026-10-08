#!/usr/bin/env bash
# Introspection SETUP: create a custom menu link in the 'main' menu that has a
# simple_menu_icons icon configured (options.menu_icon), plus one without, so an agent can
# identify which menu link carries an icon. Idempotent (removes any prior copy first).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach (["SMI Known Icon Link","SMI Plain Link"] as $t) {
    foreach ($s->getQuery()->accessCheck(FALSE)->condition("title",$t)->execute() as $id) { $s->load($id)->delete(); }
  }
  MenuLinkContent::create([
    "title" => "SMI Known Icon Link", "menu_name" => "main",
    "link" => ["uri" => "internal:/node", "options" => ["menu_icon" => ["uri" => "public://menu_icons/smi_known.svg", "fid" => 0]]],
  ])->save();
  MenuLinkContent::create([
    "title" => "SMI Plain Link", "menu_name" => "main",
    "link" => ["uri" => "internal:/user"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: main menu has 'SMI Known Icon Link' (menu_icon set) and 'SMI Plain Link' (none)"
