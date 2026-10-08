#!/usr/bin/env bash
# Introspection SETUP: create mbt_on (modify_title TRUE) and mbt_off (modify_title FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\block\Entity\Block;
  if ($b = Block::load("mbt_on")) { $b->delete(); }
  $b = Block::create([
    "id" => "mbt_on", "plugin" => "system_menu_block:main",
    "theme" => \Drupal::config("system.theme")->get("default"), "region" => "content",
    "settings" => ["id" => "system_menu_block:main", "label" => "On Nav", "label_display" => "visible", "level" => 2, "depth" => 0],
  ]);
  $b->setThirdPartySetting("menu_block_title", "modify_title", TRUE);
  $b->save();' >/dev/null 2>&1
drush php:eval '  use Drupal\block\Entity\Block;
  if ($b = Block::load("mbt_off")) { $b->delete(); }
  $b = Block::create([
    "id" => "mbt_off", "plugin" => "system_menu_block:main",
    "theme" => \Drupal::config("system.theme")->get("default"), "region" => "content",
    "settings" => ["id" => "system_menu_block:main", "label" => "Off Nav", "label_display" => "visible", "level" => 2, "depth" => 0],
  ]);
  $b->setThirdPartySetting("menu_block_title", "modify_title", FALSE);
  $b->save();' >/dev/null 2>&1
echo "setup: mbt_on modify_title=true, mbt_off modify_title=false"
