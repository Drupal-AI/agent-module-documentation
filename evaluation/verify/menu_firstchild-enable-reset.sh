#!/usr/bin/env bash
# Execution RESET: ensure a main-menu link 'MFC Task Parent' exists with menu_firstchild
# DISABLED (a normal link to /user), plus a child link, so verify FAILS until the agent turns
# first-child on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $parents = $storage->loadByProperties(["title" => "MFC Task Parent"]);
  $parent = $parents ? reset($parents) : NULL;
  if (!$parent) {
    $parent = MenuLinkContent::create([
      "title" => "MFC Task Parent", "menu_name" => "main",
      "link" => ["uri" => "internal:/user"],
    ]);
    $parent->save();
  }
  else {
    $parent->set("link", ["uri" => "internal:/user"])->save();
  }
  if (!$storage->loadByProperties(["title" => "MFC Task Child"])) {
    MenuLinkContent::create([
      "title" => "MFC Task Child", "menu_name" => "main",
      "parent" => "menu_link_content:" . $parent->uuid(),
      "link" => ["uri" => "internal:/user"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: MFC Task Parent present with menu_firstchild disabled"
