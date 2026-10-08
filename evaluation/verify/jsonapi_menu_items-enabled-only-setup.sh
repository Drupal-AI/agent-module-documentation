#!/usr/bin/env bash
# Introspection SETUP: menu jmi_vis with one ENABLED link (JMI Visible) and one DISABLED link
# (JMI Hidden). The resource returns only enabled links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("jmi_vis")) {
    Menu::create(["id" => "jmi_vis", "label" => "JMI Vis Menu"])->save();
  }
  $store = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  if (empty($store->loadByProperties(["menu_name" => "jmi_vis", "title" => "JMI Visible"]))) {
    MenuLinkContent::create(["title" => "JMI Visible", "link" => ["uri" => "internal:/"], "menu_name" => "jmi_vis", "enabled" => TRUE, "weight" => 0])->save();
  }
  if (empty($store->loadByProperties(["menu_name" => "jmi_vis", "title" => "JMI Hidden"]))) {
    MenuLinkContent::create(["title" => "JMI Hidden", "link" => ["uri" => "internal:/"], "menu_name" => "jmi_vis", "enabled" => FALSE, "weight" => 1])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu jmi_vis (JMI Visible enabled, JMI Hidden disabled)"
