#!/usr/bin/env bash
# Execution RESET: ensure the Article Date/time field field_df_build exists and (re)create the
# view "date_filter_build" with NO filters at all, so verify FAILS until the agent adds the
# date_filter-improved `datetime` filter on that field.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_df_build")) {
    FieldStorageConfig::create([
      "field_name" => "field_df_build", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_df_build")) {
    FieldConfig::create([
      "field_name" => "field_df_build", "entity_type" => "node",
      "bundle" => "article", "label" => "Build moment",
    ])->save();
  }
  if ($v = View::load("date_filter_build")) { $v->delete(); }
  View::create([
    "id" => "date_filter_build",
    "label" => "Date filter build",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Master",
        "position" => 0,
        "display_options" => [
          "title" => "Date filter build",
          "filters" => [],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_df_build present; views.view.date_filter_build has no filters"
