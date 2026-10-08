#!/usr/bin/env bash
# Introspection CLEANUP: remove menuexp_data, its links, selection, and export payload.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name","menuexp_data")->execute();
  foreach (MenuLinkContent::loadMultiple($ids) as $l) { $l->delete(); }
  if ($m=Menu::load("menuexp_data")) { $m->delete(); }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",[])->save();
  \Drupal::configFactory()->getEditable("menu_export.export_data")->delete();
' >/dev/null 2>&1
echo "cleanup: menuexp_data + export payload removed"
