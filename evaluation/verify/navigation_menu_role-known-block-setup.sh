#!/usr/bin/env bash
# Introspection SETUP: place a navigation_menu_role block (nmr_known) for the main menu,
# restricted to the content_editor role, so an inspecting agent can read the role back from
# the block config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("nmr_known")) { $b->delete(); }
  $theme = \Drupal::config("system.theme")->get("default");
  Block::create([
    "id" => "nmr_known", "plugin" => "navigation_menu_role:main",
    "theme" => $theme, "region" => "content",
    "settings" => [
      "id" => "navigation_menu_role:main", "label" => "Main (editors)",
      "label_display" => "0", "level" => 1, "depth" => 0,
      "roles" => ["content_editor"],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: block nmr_known (navigation_menu_role:main) restricted to roles=[content_editor]"
