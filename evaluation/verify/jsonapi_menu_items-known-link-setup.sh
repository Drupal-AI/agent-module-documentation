#!/usr/bin/env bash
# Introspection SETUP: create a menu jmi_probe with one enabled link the jsonapi_menu_items
# resource will return, so the agent can query/inspect it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("jmi_probe")) {
    Menu::create(["id" => "jmi_probe", "label" => "JMI Probe Menu"])->save();
  }
  $existing = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["menu_name" => "jmi_probe", "title" => "JMI Probe Home"]);
  if (empty($existing)) {
    MenuLinkContent::create([
      "title" => "JMI Probe Home", "link" => ["uri" => "internal:/"],
      "menu_name" => "jmi_probe", "enabled" => TRUE, "weight" => 0,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu jmi_probe with enabled link JMI Probe Home"
