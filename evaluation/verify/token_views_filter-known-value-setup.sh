#!/usr/bin/env bash
# Introspection SETUP: create namespaced View config 'tvf_known' (config API, no entity save)
# with a 'title' string filter using token_views_filter (use_tokens=true, value
# [current-user:uid]). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views.view.tvf_known")->setData([
    "langcode" => "en", "status" => TRUE, "dependencies" => ["module" => ["node"]],
    "id" => "tvf_known", "label" => "TVF Known", "module" => "views", "description" => "",
    "tag" => "", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => ["filters" => ["title" => [
        "id" => "title", "table" => "node_field_data", "field" => "title", "plugin_id" => "string",
        "entity_type" => "node", "entity_field" => "title", "operator" => "=",
        "value" => "[current-user:uid]", "use_tokens" => TRUE,
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "setup: views.view.tvf_known title filter use_tokens=true value=[current-user:uid]"
