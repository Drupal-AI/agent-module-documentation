#!/usr/bin/env bash
# Introspection SETUP: build the view "date_filter_mixed" with TWO exposed date filters --
# node created (date_filter type: date, date only) and the Article Date/time field
# field_df_moment (date_filter type: datetime, date + time). The agent must work out which
# one also collects a time of day. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_df_moment")) {
    FieldStorageConfig::create([
      "field_name" => "field_df_moment", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_df_moment")) {
    FieldConfig::create([
      "field_name" => "field_df_moment", "entity_type" => "node",
      "bundle" => "article", "label" => "Moment",
    ])->save();
  }
  if ($v = View::load("date_filter_mixed")) { $v->delete(); }
  View::create([
    "id" => "date_filter_mixed",
    "label" => "Date filter mixed",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Master",
        "position" => 0,
        "display_options" => [
          "title" => "Date filter mixed",
          "filters" => [
            "created" => [
              "id" => "created",
              "table" => "node_field_data",
              "field" => "created",
              "entity_type" => "node",
              "entity_field" => "created",
              "plugin_id" => "date",
              "operator" => "between",
              "type" => "date",
              "value" => ["min" => "-1 year", "max" => "now", "value" => ""],
              "exposed" => TRUE,
              "expose" => [
                "operator_id" => "created_op",
                "label" => "Authored on",
                "identifier" => "df_created",
                "required" => FALSE,
              ],
            ],
            "field_df_moment_value" => [
              "id" => "field_df_moment_value",
              "table" => "node__field_df_moment",
              "field" => "field_df_moment_value",
              "plugin_id" => "datetime",
              "operator" => "between",
              "type" => "datetime",
              "value" => ["min" => "now", "max" => "+1 week", "value" => ""],
              "exposed" => TRUE,
              "expose" => [
                "operator_id" => "field_df_moment_value_op",
                "label" => "Moment",
                "identifier" => "df_moment",
                "required" => FALSE,
              ],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.date_filter_mixed -> created type=date, field_df_moment_value type=datetime"
