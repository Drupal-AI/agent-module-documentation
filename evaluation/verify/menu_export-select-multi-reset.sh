#!/usr/bin/env bash
# Execution RESET: create menus "menuexp_a" and "menuexp_b" (each with a link) and clear the
# export selection, so verify FAILS until the agent selects BOTH. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  foreach (["menuexp_a"=>"MenuExp A","menuexp_b"=>"MenuExp B"] as $id=>$label) {
    if (!Menu::load($id)) { Menu::create(["id"=>$id,"label"=>$label])->save(); }
    $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name",$id)->execute();
    if (!$ids) { MenuLinkContent::create(["title"=>strtoupper($id)." Link","link"=>["uri"=>"internal:/"],"menu_name"=>$id])->save(); }
  }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",[])->save();
' >/dev/null 2>&1
echo "reset: menuexp_a + menuexp_b exist, none selected for export"
