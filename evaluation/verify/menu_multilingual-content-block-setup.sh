#!/usr/bin/env bash
# Introspection SETUP: place a menu block mm_eval_content with menu_multilingual configured to
# hide items whose linked CONTENT is untranslated. Agent reads it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("mm_eval_content")) { $b->delete(); }
  Block::create([
    "id" => "mm_eval_content", "theme" => $theme, "region" => "content", "weight" => 0,
    "plugin" => "system_menu_block:main",
    "settings" => ["id" => "system_menu_block:main", "label" => "Eval Content Menu", "provider" => "system", "label_display" => "0", "level" => 1, "depth" => 0],
    "third_party_settings" => ["menu_multilingual" => ["only_translated_labels" => FALSE, "only_translated_content" => TRUE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.mm_eval_content only_translated_content=true"
