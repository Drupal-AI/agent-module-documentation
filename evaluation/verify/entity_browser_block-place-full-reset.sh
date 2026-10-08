#!/usr/bin/env bash
# Execution RESET for "place an Entity Browser Block: node:1 as full in olivero sidebar".
# Establishes the precondition (the eval_browser Entity Browser exists so the derivative
# resolves) and clears prior state: deletes every entity_browser_block-derived block in the
# olivero `sidebar` region, so verify FAILS until the agent places a correct one.
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
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if (str_starts_with($b->getPluginId(), "entity_browser_block:")
        && $b->getTheme() === "olivero" && $b->getRegion() === "sidebar") {
      $b->delete();
    }
  }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval_browser present; entity_browser_block blocks in olivero/sidebar cleared"
