#!/usr/bin/env bash
# Execution RESET: create menu jmih_edit with a DISABLED link 'JMIH Toggle' so the endpoint the
# hypermedia link points to returns nothing (verify FAILS) until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("jmih_edit")) { Menu::create(["id" => "jmih_edit", "label" => "JMIH Edit Menu"])->save(); }
  $store = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $existing = $store->loadByProperties(["menu_name" => "jmih_edit", "title" => "JMIH Toggle"]);
  if (empty($existing)) {
    MenuLinkContent::create(["title" => "JMIH Toggle", "link" => ["uri" => "internal:/"], "menu_name" => "jmih_edit", "enabled" => FALSE, "weight" => 0])->save();
  } else { $l = reset($existing); $l->set("enabled", FALSE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu jmih_edit with DISABLED link JMIH Toggle"
