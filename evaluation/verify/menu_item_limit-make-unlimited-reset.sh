#!/usr/bin/env bash
# hard RESET (menu_item_limit): ensure menu mil_free exists and is limited to 1 item, so verify
# FAILS until it is made unlimited. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if (!Menu::load("mil_free")) { Menu::create(["id" => "mil_free", "label" => "MIL Free"])->save(); }
  \Drupal::configFactory()->getEditable("menu_item_limit.settings")->set("mil_free", 1)->save();
' >/dev/null 2>&1
echo "reset: menu mil_free limited to 1 item"
