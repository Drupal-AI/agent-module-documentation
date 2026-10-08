#!/usr/bin/env bash
# Introspection SETUP: create a FullCalendar View fcl_events with bundle colors and a
# FullCalendar Legend area (footer) whose heading level is h4, so an agent can read that back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("fcl_events")) {
    View::create([
      "id" => "fcl_events", "label" => "FCL Events", "base_table" => "node_field_data", "base_field" => "nid",
      "display" => ["default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "style" => ["type" => "fullcalendar", "options" => ["colors" => ["color_bundle" => ["article" => ["color" => "#ff0000"]]]]],
          "row" => ["type" => "fields"],
          "footer" => ["fullcalendar_legend" => [
            "id" => "fullcalendar_legend", "table" => "views", "field" => "fullcalendar_legend",
            "plugin_id" => "fullcalendar_legend", "heading_level" => "h4",
          ]],
        ],
      ]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: view fcl_events has fullcalendar_legend area heading_level=h4"
