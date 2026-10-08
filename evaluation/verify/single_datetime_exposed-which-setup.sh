#!/usr/bin/env bash
# Introspection SETUP: create a View (sdt_exp_which) whose default display has TWO exposed
# filters — an absolute-date filter on "created" (plugin_id=date, value.type=date, identifier
# "sdt_when") that single_datetime_exposed WILL enhance, and a plain "title" string filter
# (plugin_id=string, identifier "sdt_title") that it will NOT. The agent must inspect the view
# config and say which exposed filter gets the datetimepicker. Raw config factory. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $data = [
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node", "user"]],
    "id" => "sdt_exp_which", "label" => "SDT Exposed Which", "module" => "views",
    "description" => "", "tag" => "", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => ["filters" => [
        "created" => [
          "id" => "created", "table" => "node_field_data", "field" => "created", "plugin_id" => "date",
          "entity_type" => "node", "entity_field" => "created", "exposed" => TRUE,
          "expose" => ["identifier" => "sdt_when", "label" => "When", "operator_id" => "created_op"],
          "operator" => ">", "value" => ["type" => "date", "value" => ""],
        ],
        "title" => [
          "id" => "title", "table" => "node_field_data", "field" => "title", "plugin_id" => "string",
          "entity_type" => "node", "entity_field" => "title", "exposed" => TRUE,
          "expose" => ["identifier" => "sdt_title", "label" => "Title", "operator_id" => "title_op"],
          "operator" => "contains", "value" => "",
        ],
      ]],
    ]],
  ];
  \Drupal::configFactory()->getEditable("views.view.sdt_exp_which")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view sdt_exp_which has exposed date filter sdt_when (plugin_id date) + exposed string filter sdt_title"
