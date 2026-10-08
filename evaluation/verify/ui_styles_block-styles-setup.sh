#!/usr/bin/env bash
# Introspection SETUP (ui_styles_block): place a block 'ui_styles_eval_block' and apply a
# UI Styles content style (extra class ui-styles-eval-content) so an agent can read it back
# from block.block.ui_styles_eval_block. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_block -y >/dev/null 2>&1
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $block = Block::load("ui_styles_eval_block");
  if (!$block) {
    $block = Block::create([
      "id" => "ui_styles_eval_block",
      "plugin" => "system_powered_by_block",
      "theme" => $theme,
      "region" => "content",
      "settings" => ["id" => "system_powered_by_block", "label" => "Eval Powered", "label_display" => "0"],
    ]);
  }
  $block->setThirdPartySetting("ui_styles", "content", ["selected" => [], "extra" => "ui-styles-eval-content"]);
  $block->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.ui_styles_eval_block content style extra=ui-styles-eval-content"
