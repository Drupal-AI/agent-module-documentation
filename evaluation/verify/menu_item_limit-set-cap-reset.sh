#!/usr/bin/env bash
# hard RESET (menu_item_limit): ensure menu mil_task exists with NO item limit (key cleared),
# so verify FAILS until a cap of 2 is set. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if (!Menu::load("mil_task")) { Menu::create(["id" => "mil_task", "label" => "MIL Task"])->save(); }
  \Drupal::configFactory()->getEditable("menu_item_limit.settings")->clear("mil_task")->save();
' >/dev/null 2>&1
echo "reset: menu mil_task present with no item limit"
