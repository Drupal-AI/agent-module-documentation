#!/usr/bin/env bash
# Introspection SETUP: write a view 'tv_probe' whose default display includes the
# translation_views translation-status field. Raw config write. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $name="views.view.tv_probe";
  \Drupal::configFactory()->getEditable($name)->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>["module"=>["node","translation_views","user"]],
    "id"=>"tv_probe","label"=>"TV Probe","module"=>"views","description"=>"","tag"=>"",
    "base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "fields"=>[
          "title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"],
          "translation_status"=>["id"=>"translation_status","table"=>"node_translation","field"=>"translation_status","plugin_id"=>"translation_views_status","entity_type"=>"node"],
        ],
      ]]],
  ])->save();
' >/dev/null 2>&1
echo "setup: view tv_probe includes translation_views_status field"
