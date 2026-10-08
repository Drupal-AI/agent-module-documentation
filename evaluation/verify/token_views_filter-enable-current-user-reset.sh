#!/usr/bin/env bash
# Execution RESET: (re)create View config 'tvf_task' (config API) with a 'title' string filter
# that does NOT use tokens (use_tokens=false, value ''), so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views.view.tvf_task")->setData([
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node"]],
    "id" => "tvf_task", "label" => "TVF Task", "module" => "views", "description" => "",
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
echo "reset: views.view.tvf_task title filter use_tokens=false value=''"
