#!/usr/bin/env bash
# Introspection SETUP: create a View (sdt_exp_known) whose default display has an EXPOSED,
# absolute-date filter on the node "created" field (plugin_id=date, value.type=date, exposed
# identifier "sdt_created") — exactly the shape single_datetime_exposed enhances with the
# datetimepicker. Written via the raw config factory so it works despite the unrelated Views
# filter-discovery fatal on this shared site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $data = [
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node", "user"]],
    "id" => "sdt_exp_known", "label" => "SDT Exposed Known", "module" => "views",
    "description" => "", "tag" => "", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => ["filters" => ["created" => [
        "id" => "created", "table" => "node_field_data", "field" => "created", "plugin_id" => "date",
        "entity_type" => "node", "entity_field" => "created", "exposed" => TRUE,
        "expose" => ["identifier" => "sdt_created", "label" => "Authored on", "operator_id" => "created_op"],
        "operator" => "between", "value" => ["type" => "date", "min" => "", "max" => "", "value" => ""],
      ]]],
    ]],
  ];
  \Drupal::configFactory()->getEditable("views.view.sdt_exp_known")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view sdt_exp_known has exposed date filter (identifier sdt_created, plugin_id date, value.type date)"
