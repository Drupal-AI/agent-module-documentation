#!/usr/bin/env bash
# Execution RESET: create view jav_task with jsonapi_views EXPOSED (enabled=true), so verify
# FAILs until the agent disables exposure on its default display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("jav_task")) { $v->delete(); }
  View::create([
    "id" => "jav_task", "label" => "JAV Task", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["display_extenders" => ["jsonapi_views" => ["enabled" => TRUE]]],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jav_task default display jsonapi_views.enabled=true (exposed)"
