#!/usr/bin/env bash
# Execution RESET: create a FullCalendar View fcl_task WITH bundle colors but WITHOUT any legend
# area, so verify FAILS until the agent adds a fullcalendar_legend area. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("fcl_task")) { $v->delete(); }
  View::create([
    "id" => "fcl_task", "label" => "FCL Task", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "fullcalendar", "options" => ["colors" => ["color_bundle" => ["article" => ["color" => "#0000ff"]]]]],
        "row" => ["type" => "fields"],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "reset: view fcl_task present (fullcalendar style, NO legend area)"
