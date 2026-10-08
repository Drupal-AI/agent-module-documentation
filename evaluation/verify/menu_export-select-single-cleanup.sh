#!/usr/bin/env bash
# Execution CLEANUP: remove menuexp_task, its links, and clear the selection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name","menuexp_task")->execute();
  foreach (MenuLinkContent::loadMultiple($ids) as $l) { $l->delete(); }
  if ($m=Menu::load("menuexp_task")) { $m->delete(); }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",[])->save();
' >/dev/null 2>&1
echo "cleanup: menuexp_task removed, selection cleared"
