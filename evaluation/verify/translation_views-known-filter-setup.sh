#!/usr/bin/env bash
# Introspection SETUP: write a view 'tv_demo' whose default display uses the translation_views
# target-language exposed filter. Written via the config factory (raw) so no view handler is
# instantiated (translation_views data is only registered when content translation is enabled).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $name="views.view.tv_demo";
  \Drupal::configFactory()->getEditable($name)->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>["module"=>["node","translation_views","user"]],
    "id"=>"tv_demo","label"=>"TV Demo","module"=>"views","description"=>"","tag"=>"",
    "base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "filters"=>["translation_target_language"=>["id"=>"translation_target_language","table"=>"node_translation","field"=>"translation_target_language","plugin_id"=>"translation_views_target_language","entity_type"=>"node","exposed"=>true,"expose"=>["identifier"=>"translation_target_language","label"=>"Target language"]]],
        "fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"]],
      ]]],
  ])->save();
' >/dev/null 2>&1
echo "setup: view tv_demo uses translation_views_target_language filter"
