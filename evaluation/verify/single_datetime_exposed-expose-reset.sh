#!/usr/bin/env bash
# Execution RESET: create a View (sdt_exp_task) with an absolute-date filter on "created"
# (plugin_id=date, value.type=date) that is NOT exposed (exposed=false). single_datetime_exposed
# only enhances EXPOSED date filters, so verify FAILs until the agent exposes it. Raw config
# factory (works despite the unrelated Views filter-discovery fatal on this site). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $data = [
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node", "user"]],
    "id" => "sdt_exp_task", "label" => "SDT Exposed Task", "module" => "views",
    "description" => "", "tag" => "", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => ["filters" => ["created" => [
        "id" => "created", "table" => "node_field_data", "field" => "created", "plugin_id" => "date",
        "entity_type" => "node", "entity_field" => "created", "exposed" => FALSE,
        "operator" => "between", "value" => ["type" => "date", "min" => "", "max" => "", "value" => ""],
      ]]],
    ]],
  ];
  \Drupal::configFactory()->getEditable("views.view.sdt_exp_task")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sdt_exp_task has a date filter that is NOT exposed"
