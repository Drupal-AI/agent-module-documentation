#!/usr/bin/env bash
# Introspection SETUP: create menu block mbt_known with modify_title enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\block\Entity\Block;
  if ($b = Block::load("mbt_known")) { $b->delete(); }
  $b = Block::create([
    "id" => "mbt_known", "plugin" => "system_menu_block:main",
    "theme" => \Drupal::config("system.theme")->get("default"), "region" => "content",
    "settings" => ["id" => "system_menu_block:main", "label" => "Known Nav", "label_display" => "visible", "level" => 2, "depth" => 0],
  ]);
  $b->setThirdPartySetting("menu_block_title", "modify_title", TRUE);
  $b->save();' >/dev/null 2>&1
echo "setup: block.block.mbt_known has menu_block_title.modify_title=true"
