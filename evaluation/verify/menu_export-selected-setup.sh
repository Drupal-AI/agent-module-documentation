#!/usr/bin/env bash
# Introspection SETUP: create a custom menu "menuexp_known" with a link, and mark it for
# export in menu_export.settings, so an agent can read back which menu is selected.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("menuexp_known")) { Menu::create(["id"=>"menuexp_known","label"=>"MenuExp Known"])->save(); }
  $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name","menuexp_known")->execute();
  if (!$ids) { MenuLinkContent::create(["title"=>"Known Home","link"=>["uri"=>"internal:/"],"menu_name"=>"menuexp_known"])->save(); }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",["menuexp_known"])->save();
' >/dev/null 2>&1
echo "setup: menu_export.settings menus=[menuexp_known]"
