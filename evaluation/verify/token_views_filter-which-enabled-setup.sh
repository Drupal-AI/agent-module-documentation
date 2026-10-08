#!/usr/bin/env bash
# Introspection SETUP: create namespaced View config 'tvf_toggle' (config API) with two
# filters: 'title' (string, use_tokens=true) and 'created' (date, use_tokens=false). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views.view.tvf_toggle")->setData([
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node"]],
    "id" => "tvf_toggle", "label" => "TVF Toggle", "module" => "views", "description" => "",
    "tag" => "", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => ["filters" => [
        "title" => [
          "id" => "title", "table" => "node_field_data", "field" => "title", "plugin_id" => "string",
          "entity_type" => "node", "entity_field" => "title", "operator" => "=",
          "value" => "[site:name]", "use_tokens" => TRUE,
        ],
        "created" => [
          "id" => "created", "table" => "node_field_data", "field" => "created", "plugin_id" => "date",
          "entity_type" => "node", "entity_field" => "created", "operator" => ">",
          "value" => ["value" => "", "type" => "date"], "use_tokens" => FALSE,
        ],
      ]],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "setup: views.view.tvf_toggle title(use_tokens=true) created(use_tokens=false)"
