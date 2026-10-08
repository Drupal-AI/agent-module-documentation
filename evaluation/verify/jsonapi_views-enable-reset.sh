#!/usr/bin/env bash
# Execution RESET: create view jav_task2 with jsonapi_views NOT exposed (enabled=false), so
# verify FAILs until the agent exposes it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("jav_task2")) { $v->delete(); }
  View::create([
    "id" => "jav_task2", "label" => "JAV Task 2", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["display_extenders" => ["jsonapi_views" => ["enabled" => FALSE]]],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jav_task2 default display jsonapi_views.enabled=false (not exposed)"
