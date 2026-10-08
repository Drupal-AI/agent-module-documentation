#!/usr/bin/env bash
# Introspection SETUP: place a block (mc_known) with a menu_position visibility condition
# targeting the whole 'main' menu, so an inspecting agent can read which menu it targets.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("mc_known")) { $b->delete(); }
  Block::create([
    "id" => "mc_known", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "MC Known", "label_display" => "0"],
    "visibility" => ["menu_position" => ["id" => "menu_position", "menu_parent" => "main:", "negate" => FALSE, "context_mapping" => []]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block mc_known has visibility.menu_position.menu_parent = 'main:'"
