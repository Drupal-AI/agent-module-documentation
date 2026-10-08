#!/usr/bin/env bash
# Introspection SETUP for entity_browser_block "known selection".
# Ensures an Entity Browser (eval_browser) exists so the derivative resolves, then places a
# KNOWN Entity Browser Block config entity (block.block.ebb_eval_known) that renders node:1
# in the `teaser` view mode. The inspecting agent must read entity_ids / view_modes back.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $eb = \Drupal::entityTypeManager()->getStorage("entity_browser");
  if (!$eb->load("eval_browser")) {
    $eb->create([
      "name" => "eval_browser", "label" => "Eval Browser",
      "display" => "modal",
      "display_configuration" => ["width" => "650", "height" => "500", "link_text" => "Select", "auto_open" => false],
      "selection_display" => "no_display", "selection_display_configuration" => [],
      "widget_selector" => "single", "widget_selector_configuration" => [], "widgets" => [],
    ])->save();
  }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
  \Drupal\block\Entity\Block::load("ebb_eval_known")?->delete();
  \Drupal\block\Entity\Block::create([
    "id" => "ebb_eval_known", "theme" => "olivero", "region" => "content", "weight" => 0,
    "plugin" => "entity_browser_block:eval_browser",
    "settings" => [
      "id" => "entity_browser_block:eval_browser", "label" => "Known EBB",
      "label_display" => "0", "provider" => "entity_browser_block",
      "entity_ids" => ["node:1"], "view_modes" => ["node:1" => "teaser"],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: placed block ebb_eval_known (entity_ids=[node:1], view_modes={node:1:teaser})"
