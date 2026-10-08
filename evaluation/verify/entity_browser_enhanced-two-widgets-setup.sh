#!/usr/bin/env bash
# Introspection SETUP: create an entity browser (ebe_two) with TWO View widgets, "Photos" and
# "Documents". Only the Documents widget has an enhancer assigned (autoselect); the Photos
# widget is explicitly _none_. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $photos = "aaaaaaaa-1111-4111-8111-ebe000000002";
  $docs   = "aaaaaaaa-1111-4111-8111-ebe000000003";
  $storage = \Drupal::entityTypeManager()->getStorage("entity_browser");
  if ($b = $storage->load("ebe_two")) { $b->delete(); }
  $storage->create([
    "name" => "ebe_two",
    "label" => "EBE Two Widgets",
    "display" => "modal",
    "display_configuration" => ["width" => "650", "height" => "500", "link_text" => "Select", "auto_open" => FALSE],
    "selection_display" => "no_display",
    "selection_display_configuration" => [],
    "widget_selector" => "tabs",
    "widget_selector_configuration" => [],
    "widgets" => [
      $photos => ["id" => "view", "uuid" => $photos, "label" => "Photos", "weight" => 0,
        "settings" => ["submit_text" => "Select", "auto_select" => FALSE, "view" => "image_browser", "view_display" => "entity_browser"]],
      $docs => ["id" => "view", "uuid" => $docs, "label" => "Documents", "weight" => 1,
        "settings" => ["submit_text" => "Select", "auto_select" => TRUE, "view" => "image_browser", "view_display" => "entity_browser"]],
    ],
  ])->save();
  \Drupal::configFactory()->getEditable("entity_browser_enhanced.widgets.ebe_two")
    ->set($photos, "_none_")
    ->set($docs, "autoselect")
    ->save();
' >/dev/null 2>&1
echo "setup: ebe_two - Photos widget _none_, Documents widget autoselect"
