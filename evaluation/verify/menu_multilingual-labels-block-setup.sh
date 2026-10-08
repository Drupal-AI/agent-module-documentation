#!/usr/bin/env bash
# Introspection SETUP: place a menu block (system_menu_block:main) named mm_eval_labels with
# menu_multilingual configured to hide items without a translated LABEL. Agent reads it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("mm_eval_labels")) { $b->delete(); }
  Block::create([
    "id" => "mm_eval_labels", "theme" => $theme, "region" => "content", "weight" => 0,
    "plugin" => "system_menu_block:main",
    "settings" => ["id" => "system_menu_block:main", "label" => "Eval Labels Menu", "provider" => "system", "label_display" => "0", "level" => 1, "depth" => 0],
    "third_party_settings" => ["menu_multilingual" => ["only_translated_labels" => TRUE, "only_translated_content" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.mm_eval_labels only_translated_labels=true"
