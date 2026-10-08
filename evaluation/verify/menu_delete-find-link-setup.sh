#!/usr/bin/env bash
# Introspection SETUP: create menu md_src with a single distinctively-titled content link, so
# an agent can inspect the live menu and report the link title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("md_src")) { Menu::create(["id" => "md_src", "label" => "MD Src"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $c = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_src")->count()->execute();
  if ($c == 0) {
    MenuLinkContent::create(["title" => "MD Findme Link", "link" => ["uri" => "internal:/"], "menu_name" => "md_src"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu md_src has link 'MD Findme Link'"
