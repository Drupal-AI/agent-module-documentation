#!/usr/bin/env bash
# Execution RESET: ensure menu block mbt_task exists with modify_title FALSE (so verify FAILS until
# the agent enables it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\block\Entity\Block;
  if ($b = Block::load("mbt_task")) { $b->delete(); }
  $b = Block::create([
    "id" => "mbt_task", "plugin" => "system_menu_block:main",
    "theme" => \Drupal::config("system.theme")->get("default"), "region" => "content",
    "settings" => ["id" => "system_menu_block:main", "label" => "Task Nav", "label_display" => "visible", "level" => 2, "depth" => 0],
  ]);
  $b->setThirdPartySetting("menu_block_title", "modify_title", FALSE);
  $b->save();' >/dev/null 2>&1
echo "reset: block.block.mbt_task present with menu_block_title.modify_title=FALSE"
