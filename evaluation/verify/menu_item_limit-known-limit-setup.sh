#!/usr/bin/env bash
# medium SETUP (menu_item_limit): create menu mil_known and set its item limit to 3. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if (!Menu::load("mil_known")) { Menu::create(["id" => "mil_known", "label" => "MIL Known"])->save(); }
  \Drupal::configFactory()->getEditable("menu_item_limit.settings")->set("mil_known", 3)->save();
' >/dev/null 2>&1
echo "setup: menu mil_known created; menu_item_limit.settings:mil_known = 3"
