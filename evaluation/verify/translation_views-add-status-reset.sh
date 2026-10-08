#!/usr/bin/env bash
# Execution RESET: write a plain node view 'tv_task2' (title field only, NO translation_views
# handlers) so verify fails until the agent adds the translation_views status field. Raw config
# write. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $name="views.view.tv_task2";
  \Drupal::configFactory()->getEditable($name)->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>["module"=>["node","user"]],
    "id"=>"tv_task2","label"=>"TV Task2","module"=>"views","description"=>"","tag"=>"",
    "base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"]],
      ]]],
  ])->save();
' >/dev/null 2>&1
echo "reset: view tv_task2 has no translation_views handlers"
