#!/usr/bin/env bash
# Execution RESET: create menu jmi_edit with a DISABLED link 'Toggle Link' so the resource does NOT
# return it (verify FAILS) until the agent enables the link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("jmi_edit")) {
    Menu::create(["id" => "jmi_edit", "label" => "JMI Edit Menu"])->save();
  }
  $store = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $existing = $store->loadByProperties(["menu_name" => "jmi_edit", "title" => "Toggle Link"]);
  if (empty($existing)) {
    MenuLinkContent::create(["title" => "Toggle Link", "link" => ["uri" => "internal:/"], "menu_name" => "jmi_edit", "enabled" => FALSE, "weight" => 0])->save();
  }
  else {
    $l = reset($existing); $l->set("enabled", FALSE)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu jmi_edit with DISABLED link Toggle Link"
