#!/usr/bin/env bash
# Execution RESET: (re)create the view "date_filter_task" with a single NON-exposed date
# filter on node created (operator between) and NO date_filter `type` option, so verify FAILS
# until the agent exposes it and sets the module's "Filter type" to Date and time.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("date_filter_task")) { $v->delete(); }
  View::create([
    "id" => "date_filter_task",
    "label" => "Date filter task",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Master",
        "position" => 0,
        "display_options" => [
          "title" => "Date filter task",
          "filters" => [
            "created" => [
              "id" => "created",
              "table" => "node_field_data",
              "field" => "created",
              "entity_type" => "node",
              "entity_field" => "created",
              "plugin_id" => "date",
              "operator" => "between",
              "value" => ["min" => "", "max" => "", "value" => ""],
              "exposed" => FALSE,
              "expose" => ["operator_id" => "", "label" => "", "identifier" => "", "required" => FALSE],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.date_filter_task created filter is NOT exposed and has no date_filter type option"
