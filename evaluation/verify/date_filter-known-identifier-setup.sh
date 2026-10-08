#!/usr/bin/env bash
# Introspection SETUP: create the view "date_filter_known" with one exposed date filter on
# node created, configured the date_filter way: top-level `type: datetime` (the module's
# "Filter type: Date and time" radio), operator `between`, exposed identifier
# `df_created_range`. The agent must read this back off the live views config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("date_filter_known")) { $v->delete(); }
  View::create([
    "id" => "date_filter_known",
    "label" => "Date filter known",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Master",
        "position" => 0,
        "display_options" => [
          "title" => "Date filter known",
          "filters" => [
            "created" => [
              "id" => "created",
              "table" => "node_field_data",
              "field" => "created",
              "entity_type" => "node",
              "entity_field" => "created",
              "plugin_id" => "date",
              "operator" => "between",
              "type" => "datetime",
              "value" => ["min" => "-1 month", "max" => "now", "value" => ""],
              "exposed" => TRUE,
              "expose" => [
                "operator_id" => "created_op",
                "label" => "Authored on",
                "identifier" => "df_created_range",
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
echo "setup: views.view.date_filter_known created filter -> type=datetime operator=between identifier=df_created_range"
