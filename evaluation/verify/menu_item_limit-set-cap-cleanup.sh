#!/usr/bin/env bash
# hard CLEANUP (menu_item_limit): remove menu mil_task and its limit key. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if ($m = Menu::load("mil_task")) { $m->delete(); }
  \Drupal::configFactory()->getEditable("menu_item_limit.settings")->clear("mil_task")->save();
' >/dev/null 2>&1
echo "cleanup: menu mil_task and its limit removed"
