#!/usr/bin/env bash
# Execution CLEANUP: delete the mm_mig_src / mm_mig_dst menus and their content links. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach (["mm_mig_src", "mm_mig_dst"] as $m) {
    $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name", $m)->execute();
    if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
    if ($menu = Menu::load($m)) { $menu->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mm_mig_src / mm_mig_dst removed"
