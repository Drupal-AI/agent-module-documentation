#!/usr/bin/env bash
# Introspection SETUP: create menu jmih_two with an enabled link so the agent can state the
# submodule's derived link_key (menu_items--jmih_two) and the item the endpoint returns. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("jmih_two")) { Menu::create(["id" => "jmih_two", "label" => "JMIH Two Menu"])->save(); }
  $store = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  if (empty($store->loadByProperties(["menu_name" => "jmih_two", "title" => "JMIH Shown"]))) {
    MenuLinkContent::create(["title" => "JMIH Shown", "link" => ["uri" => "internal:/"], "menu_name" => "jmih_two", "enabled" => TRUE, "weight" => 0])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu jmih_two with link JMIH Shown"
