#!/usr/bin/env bash
# Execution RESET: (re)create View config 'tvf_build' (config API) with a 'title' string filter
# without tokens, so verify FAILS until the agent enables tokens with value [site:name].
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views.view.tvf_build")->setData([
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node"]],
    "id" => "tvf_build", "label" => "TVF Build", "module" => "views", "description" => "",
    "tag" => "", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => ["filters" => ["title" => [
        "id" => "title", "table" => "node_field_data", "field" => "title", "plugin_id" => "string",
        "entity_type" => "node", "entity_field" => "title", "operator" => "=",
        "value" => "", "use_tokens" => FALSE,
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "reset: views.view.tvf_build title filter use_tokens=false value=''"
