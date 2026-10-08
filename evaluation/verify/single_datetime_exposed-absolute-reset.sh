#!/usr/bin/env bash
# Execution RESET: create a View (sdt_exp_abs) with an EXPOSED "created" date filter, but whose
# value.type is "offset" (a relative-date filter). single_datetime_exposed only enhances filters
# whose value.type === "date", so verify FAILs until the agent switches the exposed filter to an
# absolute-date value (value.type=date). Raw config factory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $data = [
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node", "user"]],
    "id" => "sdt_exp_abs", "label" => "SDT Exposed Absolute", "module" => "views",
    "description" => "", "tag" => "", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => ["filters" => ["created" => [
        "id" => "created", "table" => "node_field_data", "field" => "created", "plugin_id" => "date",
        "entity_type" => "node", "entity_field" => "created", "exposed" => TRUE,
        "expose" => ["identifier" => "sdt_created", "label" => "Authored on", "operator_id" => "created_op"],
        "operator" => ">", "value" => ["type" => "offset", "value" => "-1 month"],
      ]]],
    ]],
  ];
  \Drupal::configFactory()->getEditable("views.view.sdt_exp_abs")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sdt_exp_abs has an exposed date filter with value.type=offset (relative)"
