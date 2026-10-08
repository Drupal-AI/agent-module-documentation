#!/usr/bin/env bash
# Execution RESET: (re)create the entity browser ebe_task with a single View widget and REMOVE
# any enhancer assignment, so verify FAILS until the agent assigns one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $uuid = "aaaaaaaa-1111-4111-8111-ebe000000004";
  $storage = \Drupal::entityTypeManager()->getStorage("entity_browser");
  if ($b = $storage->load("ebe_task")) { $b->delete(); }
  $storage->create([
    "name" => "ebe_task",
    "label" => "EBE Task Browser",
    "display" => "modal",
    "display_configuration" => ["width" => "650", "height" => "500", "link_text" => "Select images", "auto_open" => FALSE],
    "selection_display" => "no_display",
    "selection_display_configuration" => [],
    "widget_selector" => "tabs",
    "widget_selector_configuration" => [],
    "widgets" => [
      $uuid => ["id" => "view", "uuid" => $uuid, "label" => "Media library", "weight" => 0,
        "settings" => ["submit_text" => "Select", "auto_select" => FALSE, "view" => "image_browser", "view_display" => "entity_browser"]],
    ],
  ])->save();
  \Drupal::configFactory()->getEditable("entity_browser_enhanced.widgets.ebe_task")->delete();
' >/dev/null 2>&1
echo "reset: ebe_task exists with one View widget and no enhancer assigned"
