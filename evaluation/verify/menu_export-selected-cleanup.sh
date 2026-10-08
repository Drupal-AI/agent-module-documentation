#!/usr/bin/env bash
# Introspection CLEANUP: delete menuexp_known (and its links) and clear the selection.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name","menuexp_known")->execute();
  foreach (MenuLinkContent::loadMultiple($ids) as $l) { $l->delete(); }
  if ($m=Menu::load("menuexp_known")) { $m->delete(); }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",[])->save();
' >/dev/null 2>&1
echo "cleanup: menuexp_known removed, selection cleared"
