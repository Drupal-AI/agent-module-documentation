#!/usr/bin/env bash
# Introspection CLEANUP: delete all content links in md_known and the menu itself. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_known")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  if ($m = Menu::load("md_known")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu md_known and its links removed"
