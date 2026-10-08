#!/usr/bin/env bash
# Introspection SETUP: place a cheeseburger_menu block "cbm_known" with a known left-side
# background color (#654321) and the Main menu aggregated, so an inspecting agent can read the
# color back from the block config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("cbm_known")) { $b->delete(); }
  Block::create([
    "id" => "cbm_known", "theme" => $theme, "region" => "content", "plugin" => "cheeseburger_menu",
    "settings" => [
      "id" => "cheeseburger_menu", "label" => "CBM Known", "label_display" => "0",
      "left_side_background_color" => "#654321",
      "menus" => ["main" => ["id" => "main", "menu_type" => "menu", "weight" => 0, "settings" => []]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block cbm_known (cheeseburger_menu) placed with left_side_background_color=#654321"
