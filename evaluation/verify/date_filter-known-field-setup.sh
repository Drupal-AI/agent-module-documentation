#!/usr/bin/env bash
# Introspection SETUP: add a Date/time field field_df_known to Article and build the view
# "date_filter_field" whose only exposed filter is a date_filter-improved `datetime` filter
# on that field (type: datetime, operator >=). The agent must inspect the live view and name
# the field it filters on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_df_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_df_known", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_df_known")) {
    FieldConfig::create([
      "field_name" => "field_df_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known moment",
    ])->save();
  }
  if ($v = View::load("date_filter_field")) { $v->delete(); }
  View::create([
    "id" => "date_filter_field",
    "label" => "Date filter field",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Master",
        "position" => 0,
        "display_options" => [
          "title" => "Date filter field",
          "filters" => [
            "field_df_known_value" => [
              "id" => "field_df_known_value",
              "table" => "node__field_df_known",
              "field" => "field_df_known_value",
              "plugin_id" => "datetime",
              "operator" => ">=",
              "type" => "datetime",
              "value" => ["min" => "", "max" => "", "value" => "now"],
              "exposed" => TRUE,
              "expose" => [
                "operator_id" => "field_df_known_value_op",
                "label" => "Known moment",
                "identifier" => "df_known_from",
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
echo "setup: node.article field_df_known + views.view.date_filter_field (datetime filter, type=datetime)"
