#!/usr/bin/env bash
# Introspection SETUP: place a views_exposed_filter_blocks block "vefb_eval2" targeting
# content:page_1 but with form_state_always_process set to the NON-default value FALSE (default
# is TRUE), so an inspecting agent must read the live block config to report the value.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("vefb_eval2")) { $b->delete(); }
  Block::create([
    "id" => "vefb_eval2",
    "theme" => $theme,
    "region" => "content",
    "plugin" => "views_exposed_filter_blocks_block",
    "weight" => 0,
    "settings" => [
      "id" => "views_exposed_filter_blocks_block",
      "label" => "Vefb Eval2 Filters",
      "label_display" => "0",
      "provider" => "views_exposed_filter_blocks",
      "view_display" => "content:page_1",
      "form_state_always_process" => FALSE,
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.vefb_eval2 has form_state_always_process=FALSE"
