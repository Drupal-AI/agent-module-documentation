#!/usr/bin/env bash
# Execution RESET (ui_styles_block): ensure block 'ui_styles_eval_block' exists WITHOUT any
# ui_styles third-party settings, so verify FAILS until the agent applies a style. Idempotent.
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
    $block->save();
  }
  foreach (["block", "title", "content"] as $part) {
    $block->unsetThirdPartySetting("ui_styles", $part);
  }
  $block->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block ui_styles_eval_block present with no ui_styles third-party settings"
