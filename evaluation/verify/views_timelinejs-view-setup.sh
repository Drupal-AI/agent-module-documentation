#!/usr/bin/env bash
# Introspection SETUP: create a View vtl_med_view whose default display uses the timelinejs style
# with the Start date mapped to the 'created' field, so an inspecting agent can read back which
# View uses the timeline style and which field is its start date. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vtl_med_view")) {
    View::create([
      "id" => "vtl_med_view",
      "label" => "VTL Med View",
      "base_table" => "node_field_data",
      "base_field" => "nid",
      "display" => [
        "default" => [
          "display_plugin" => "default",
          "id" => "default",
          "display_title" => "Default",
          "position" => 0,
          "display_options" => [
            "fields" => [
              "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","entity_type"=>"node","entity_field"=>"title","plugin_id"=>"field"],
              "created" => ["id"=>"created","table"=>"node_field_data","field"=>"created","entity_type"=>"node","entity_field"=>"created","plugin_id"=>"field","type"=>"timestamp"],
            ],
            "style" => [
              "type" => "timelinejs",
              "options" => [
                "timeline_fields" => ["start_date" => "created", "headline" => "title"],
              ],
            ],
            "row" => ["type" => "fields"],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: View vtl_med_view uses timelinejs style, start_date=created"
