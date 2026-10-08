#!/usr/bin/env bash
# Introspection SETUP: create menu jmih_probe with an enabled link. The hypermedia submodule would
# advertise a menu_items--jmih_probe link at /jsonapi pointing to /jsonapi/menu_items/jmih_probe;
# this fixture lets the agent inspect that endpoint's content. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("jmih_probe")) { Menu::create(["id" => "jmih_probe", "label" => "JMIH Probe Menu"])->save(); }
  $store = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  if (empty($store->loadByProperties(["menu_name" => "jmih_probe", "title" => "JMIH Probe Item"]))) {
    MenuLinkContent::create(["title" => "JMIH Probe Item", "link" => ["uri" => "internal:/"], "menu_name" => "jmih_probe", "enabled" => TRUE, "weight" => 0])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu jmih_probe with link JMIH Probe Item"
