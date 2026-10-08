#!/usr/bin/env bash
# Introspection SETUP: create a FullCalendar View fcl_month with a FullCalendar Legend area
# whose heading level is h2, so an agent can read that back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("fcl_month")) {
    View::create([
      "id" => "fcl_month", "label" => "FCL Month", "base_table" => "node_field_data", "base_field" => "nid",
      "display" => ["default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "style" => ["type" => "fullcalendar", "options" => ["colors" => ["color_bundle" => ["article" => ["color" => "#00ff00"]]]]],
          "row" => ["type" => "fields"],
          "footer" => ["fullcalendar_legend" => [
            "id" => "fullcalendar_legend", "table" => "views", "field" => "fullcalendar_legend",
            "plugin_id" => "fullcalendar_legend", "heading_level" => "h2",
          ]],
        ],
      ]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: view fcl_month has fullcalendar_legend area heading_level=h2"
