#!/usr/bin/env bash
# Execution RESET: (re)create menu md_task with 3 content links, so verify (which requires
# ZERO content links in md_task) FAILs until the agent bulk-deletes them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("md_task")) { Menu::create(["id" => "md_task", "label" => "MD Task"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_task")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  foreach (["MD Task 1","MD Task 2","MD Task 3"] as $t) {
    MenuLinkContent::create(["title" => $t, "link" => ["uri" => "internal:/"], "menu_name" => "md_task"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu md_task present with 3 content links"
