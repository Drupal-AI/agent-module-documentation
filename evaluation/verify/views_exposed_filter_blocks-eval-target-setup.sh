#!/usr/bin/env bash
# Introspection SETUP: place a views_exposed_filter_blocks block "vefb_eval" that renders the
# exposed filters of the core "content" view's page_1 display, so an inspecting agent can read
# back which view/display it targets. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("vefb_eval")) { $b->delete(); }
  Block::create([
    "id" => "vefb_eval",
    "theme" => $theme,
    "region" => "content",
    "plugin" => "views_exposed_filter_blocks_block",
    "weight" => 0,
    "settings" => [
      "id" => "views_exposed_filter_blocks_block",
      "label" => "Vefb Eval Filters",
      "label_display" => "0",
      "provider" => "views_exposed_filter_blocks",
      "view_display" => "content:page_1",
      "form_state_always_process" => TRUE,
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.vefb_eval (views_exposed_filter_blocks_block) targets content:page_1"
