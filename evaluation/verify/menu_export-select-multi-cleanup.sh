#!/usr/bin/env bash
# Execution CLEANUP: remove menuexp_a and menuexp_b (and their links), and clear selection.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  foreach (["menuexp_a","menuexp_b"] as $id) {
    $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name",$id)->execute();
    foreach (MenuLinkContent::loadMultiple($ids) as $l) { $l->delete(); }
    if ($m=Menu::load($id)) { $m->delete(); }
  }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",[])->save();
' >/dev/null 2>&1
echo "cleanup: menuexp_a, menuexp_b removed, selection cleared"
