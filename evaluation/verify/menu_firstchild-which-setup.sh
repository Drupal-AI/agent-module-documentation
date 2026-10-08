#!/usr/bin/env bash
# Introspection SETUP: create two main-menu links, one with menu_firstchild first-child linking
# enabled ('MFC Enabled Link') and one plain ('MFC Plain Link'), so an inspecting agent can tell
# which has the behavior enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  if (!$storage->loadByProperties(["title" => "MFC Enabled Link"])) {
    MenuLinkContent::create([
      "title" => "MFC Enabled Link", "menu_name" => "main",
      "link" => ["uri" => "route:<none>", "options" => ["menu_firstchild" => ["enabled" => TRUE]]],
    ])->save();
  }
  if (!$storage->loadByProperties(["title" => "MFC Plain Link"])) {
    MenuLinkContent::create([
      "title" => "MFC Plain Link", "menu_name" => "main",
      "link" => ["uri" => "internal:/user"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: main menu has MFC Enabled Link (first-child on) and MFC Plain Link (off)"
