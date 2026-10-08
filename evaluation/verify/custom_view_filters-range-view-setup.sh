#!/usr/bin/env bash
# Introspection SETUP: create a View cvf_range_view whose default display uses the
# custom_view_filters date_range_picker_filter handler targeting granular_field_name
# 'field_cvf_when'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("cvf_range_view")) {
    View::create([
      "id" => "cvf_range_view",
      "label" => "CVF Range View",
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
              "cvf_range" => [
                "id" => "cvf_range",
                "table" => "node_field_data",
                "field" => "date_range_picker",
                "plugin_id" => "date_range_picker_filter",
                "entity_type" => "node",
                "granular_field_name" => "field_cvf_when",
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cvf_range_view uses date_range_picker_filter on granular_field_name=field_cvf_when"
