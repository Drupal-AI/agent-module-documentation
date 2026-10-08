#!/usr/bin/env bash
# Execution RESET: place a menu block mm_task (system_menu_block:main) with menu_multilingual
# label-filtering OFF, so verify FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("mm_task")) { $b->delete(); }
  Block::create([
    "id" => "mm_task", "theme" => $theme, "region" => "content", "weight" => 0,
    "plugin" => "system_menu_block:main",
    "settings" => ["id" => "system_menu_block:main", "label" => "Task Menu", "provider" => "system", "label_display" => "0", "level" => 1, "depth" => 0],
    "third_party_settings" => ["menu_multilingual" => ["only_translated_labels" => FALSE, "only_translated_content" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block.block.mm_task present with label filtering OFF"
