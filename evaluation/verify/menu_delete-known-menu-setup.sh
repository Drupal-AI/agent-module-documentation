#!/usr/bin/env bash
# Introspection SETUP: create menu md_known with 3 content (menu_link_content) links, so an
# agent can inspect the live site and report how many content links the menu has. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("md_known")) { Menu::create(["id" => "md_known", "label" => "MD Known"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $existing = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_known")->count()->execute();
  if ($existing == 0) {
    foreach (["MD Alpha","MD Bravo","MD Charlie"] as $t) {
      MenuLinkContent::create(["title" => $t, "link" => ["uri" => "internal:/"], "menu_name" => "md_known"])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu md_known has 3 content menu links"
