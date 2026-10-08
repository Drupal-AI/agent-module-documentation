#!/usr/bin/env bash
# Introspection SETUP: create a View cvf_known_view whose default display uses the
# custom_view_filters node_granular_date_filter handler targeting granular_field_name
# 'created', so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("cvf_known_view")) {
    View::create([
      "id" => "cvf_known_view",
      "label" => "CVF Known View",
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
              "cvf_gran" => [
                "id" => "cvf_gran",
                "table" => "node_field_data",
                "field" => "nodes_granular_dates",
                "plugin_id" => "node_granular_date_filter",
                "entity_type" => "node",
                "granular_field_name" => "created",
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cvf_known_view uses node_granular_date_filter on granular_field_name=created"
