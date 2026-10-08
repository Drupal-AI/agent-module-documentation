#!/usr/bin/env bash
# Execution RESET: create menu "menuexp_task" with a link and ensure it is NOT selected for
# export (menu_export.settings menus cleared), so verify FAILS until the agent selects it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("menuexp_task")) { Menu::create(["id"=>"menuexp_task","label"=>"MenuExp Task"])->save(); }
  $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name","menuexp_task")->execute();
  if (!$ids) { MenuLinkContent::create(["title"=>"Task Link","link"=>["uri"=>"internal:/"],"menu_name"=>"menuexp_task"])->save(); }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",[])->save();
' >/dev/null 2>&1
echo "reset: menuexp_task exists, not selected for export"
