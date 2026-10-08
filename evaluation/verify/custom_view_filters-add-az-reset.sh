#!/usr/bin/env bash
# Execution RESET: (re)create View cvf_task_view with ONLY a core 'status' filter and NO
# custom_view_filters handler, so verify FAILS until the agent adds custom_az_filter.
# Idempotent (deletes and recreates). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("cvf_task_view")) { $v->delete(); }
  View::create([
    "id" => "cvf_task_view",
    "label" => "CVF Task View",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "filters" => [
            "status" => [
              "id" => "status",
              "table" => "node_field_data",
              "field" => "status",
              "plugin_id" => "boolean",
              "entity_type" => "node",
              "value" => "1",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cvf_task_view present with only a status filter (no custom_az_filter)"
