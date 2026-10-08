#!/usr/bin/env bash
# Execution RESET: (re)place block_classes_split with NO block_classes settings so verify FAILS
# on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("block_classes_split")) { $b->delete(); }
  Block::create([
    "id" => "block_classes_split", "plugin" => "system_powered_by_block",
    "theme" => $theme, "region" => "content", "weight" => 94,
    "settings" => ["id" => "system_powered_by_block", "label" => "BC Split Block", "label_display" => "visible", "provider" => "system"],
  ])->save();
' >/dev/null 2>&1
echo "reset: block_classes_split placed with no block_classes third-party settings"
