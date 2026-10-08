#!/usr/bin/env bash
# Introspection SETUP: create an entity browser (ebe_demo) with one View widget and assign the
# Enhanced Multiselect enhancer to it, i.e. write the widget UUID -> enhancer id mapping into
# the config object entity_browser_enhanced.widgets.ebe_demo. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $uuid = "aaaaaaaa-1111-4111-8111-ebe000000001";
  $storage = \Drupal::entityTypeManager()->getStorage("entity_browser");
  if ($b = $storage->load("ebe_demo")) { $b->delete(); }
  $storage->create([
    "name" => "ebe_demo",
    "label" => "EBE Demo Browser",
    "display" => "modal",
    "display_configuration" => ["width" => "650", "height" => "500", "link_text" => "Select images", "auto_open" => FALSE],
    "selection_display" => "no_display",
    "selection_display_configuration" => [],
    "widget_selector" => "tabs",
    "widget_selector_configuration" => [],
    "widgets" => [
      $uuid => [
        "id" => "view", "uuid" => $uuid, "label" => "Library", "weight" => 0,
        "settings" => ["submit_text" => "Select", "auto_select" => FALSE, "view" => "image_browser", "view_display" => "entity_browser"],
      ],
    ],
  ])->save();
  \Drupal::configFactory()->getEditable("entity_browser_enhanced.widgets.ebe_demo")
    ->set($uuid, "multiselect")->save();
' >/dev/null 2>&1
echo "setup: entity browser ebe_demo, view widget aaaaaaaa-1111-4111-8111-ebe000000001 -> multiselect"
