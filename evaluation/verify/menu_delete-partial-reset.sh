#!/usr/bin/env bash
# Execution RESET: (re)create menu md_part with 4 content links: "MD Keep A", "MD Del B",
# "MD Del C", "MD Keep D". verify requires the two "Del" links gone and the two "Keep" links
# present, so it FAILs on this full state until the agent deletes only the Del links. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("md_part")) { Menu::create(["id" => "md_part", "label" => "MD Part"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_part")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  foreach (["MD Keep A","MD Del B","MD Del C","MD Keep D"] as $t) {
    MenuLinkContent::create(["title" => $t, "link" => ["uri" => "internal:/"], "menu_name" => "md_part"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu md_part present with 4 links (2 Keep, 2 Del)"
