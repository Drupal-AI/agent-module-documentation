#!/usr/bin/env bash
# Execution CLEANUP: remove md_task links and the menu entirely. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_task")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  if ($m = Menu::load("md_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu md_task and its links removed"
