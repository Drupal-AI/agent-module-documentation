#!/usr/bin/env bash
# Execution RESET: (re)place the block block_classes_task in the default theme with NO
# block_classes third-party settings, so verify FAILS until the agent adds the classes.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("block_classes_task")) { $b->delete(); }
  Block::create([
    "id" => "block_classes_task", "plugin" => "system_powered_by_block",
    "theme" => $theme, "region" => "content", "weight" => 93,
    "settings" => ["id" => "system_powered_by_block", "label" => "BC Task Block", "label_display" => "visible", "provider" => "system"],
  ])->save();
' >/dev/null 2>&1
echo "reset: block_classes_task placed with no block_classes third-party settings"
