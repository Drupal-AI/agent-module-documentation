#!/usr/bin/env bash
# Introspection CLEANUP: delete md_src links and the menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_src")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  if ($m = Menu::load("md_src")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu md_src and its links removed"
