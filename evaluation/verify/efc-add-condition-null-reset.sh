#!/usr/bin/env bash
# Execution RESET (null variant): plain efc_task_block, empty visibility, so the null-value_source verify FAILs until built. Exit 0.
# verify FAILs until the agent adds an entity_field_condition node_field condition. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("efc_task_block")) { $b->delete(); }
  Block::create([
    "id" => "efc_task_block", "theme" => $theme, "region" => "content", "weight" => -48,
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "EFC Task", "label_display" => "0"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block efc_task_block present with empty visibility"
