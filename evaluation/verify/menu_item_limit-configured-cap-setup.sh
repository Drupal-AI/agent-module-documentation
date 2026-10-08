#!/usr/bin/env bash
# medium SETUP (menu_item_limit): create menu mil_seven and set its item limit to 7. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if (!Menu::load("mil_seven")) { Menu::create(["id" => "mil_seven", "label" => "MIL Seven"])->save(); }
  \Drupal::configFactory()->getEditable("menu_item_limit.settings")->set("mil_seven", 7)->save();
' >/dev/null 2>&1
echo "setup: menu mil_seven created; menu_item_limit.settings:mil_seven = 7"
