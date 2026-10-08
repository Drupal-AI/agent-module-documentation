#!/usr/bin/env bash
# Introspection SETUP: create a main-menu link 'MFC Routeless' with menu_firstchild enabled (so
# it has no real path of its own) so an inspecting agent can read back the URI it stores. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  if (!$storage->loadByProperties(["title" => "MFC Routeless"])) {
    MenuLinkContent::create([
      "title" => "MFC Routeless", "menu_name" => "main",
      "link" => ["uri" => "route:<none>", "options" => ["menu_firstchild" => ["enabled" => TRUE]]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: main menu link MFC Routeless stores uri route:<none> with first-child enabled"
