#!/usr/bin/env bash
# Introspection SETUP: place a Superfish domain-menu block with menu_name=footer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $t = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("dmsuperfish_known")) { $b->delete(); }
  Block::create([
    "id" => "dmsuperfish_known", "theme" => $t, "region" => "content",
    "plugin" => "domain_menus_active_domain_superfish_block",
    "settings" => [
      "id" => "domain_menus_active_domain_superfish_block",
      "label" => "Known Superfish domain menu", "label_display" => "0",
      "menu_name" => "footer",
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block dmsuperfish_known placed (menu_name=footer)"
