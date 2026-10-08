#!/usr/bin/env bash
# Introspection SETUP: create a main-menu link 'Micon Menu Med' with data-icon fa-home. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $ex = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title"=>"Micon Menu Med"]);
  if (!$ex) {
    MenuLinkContent::create([
      "title"=>"Micon Menu Med","menu_name"=>"main",
      "link"=>["uri"=>"internal:/","options"=>["attributes"=>["data-icon"=>"fa-home","data-icon-position"=>"before"]]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu link 'Micon Menu Med' data-icon=fa-home"
