#!/usr/bin/env bash
# Introspection SETUP: place two blocks; only block_classes_alpha carries a Block Classes
# content_class. The agent must work out which one has it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  foreach (["block_classes_alpha", "block_classes_beta"] as $id) {
    if ($b = Block::load($id)) { $b->delete(); }
  }
  Block::create([
    "id" => "block_classes_alpha", "plugin" => "system_powered_by_block",
    "theme" => $theme, "region" => "content", "weight" => 91,
    "settings" => ["id" => "system_powered_by_block", "label" => "BC Alpha", "label_display" => "visible", "provider" => "system"],
    "third_party_settings" => ["block_classes" => ["content_class" => "bc-alpha-content"]],
  ])->save();
  Block::create([
    "id" => "block_classes_beta", "plugin" => "system_powered_by_block",
    "theme" => $theme, "region" => "content", "weight" => 92,
    "settings" => ["id" => "system_powered_by_block", "label" => "BC Beta", "label_display" => "visible", "provider" => "system"],
  ])->save();
' >/dev/null 2>&1
echo "setup: block_classes_alpha has content_class=bc-alpha-content, block_classes_beta has none"
