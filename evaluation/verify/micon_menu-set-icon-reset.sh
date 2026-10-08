#!/usr/bin/env bash
# Execution RESET: ensure a main-menu link 'Micon Menu Task' exists with NO data-icon, so verify
# FAILs until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  foreach (\Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title"=>"Micon Menu Task"]) as $m) { $m->delete(); }
  MenuLinkContent::create([
    "title"=>"Micon Menu Task","menu_name"=>"main",
    "link"=>["uri"=>"internal:/","options"=>[]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: menu link 'Micon Menu Task' present, no data-icon"
