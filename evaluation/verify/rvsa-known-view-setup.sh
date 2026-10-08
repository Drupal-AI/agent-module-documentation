#!/usr/bin/env bash
# Introspection SETUP: view rvsa_known whose field uses the search_api_field_export handler.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("rvsa_known")) { $v->delete(); }
  View::create([
    "id"=>"rvsa_known","label"=>"RVSA Known","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"search_api_field_export","type"=>"string","entity_type"=>"node","entity_field"=>"title"]],
        "style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]],
      "rest_export_1"=>["display_plugin"=>"rest_export","id"=>"rest_export_1","display_title"=>"REST export","position"=>1,
        "display_options"=>["path"=>"rvsa-known","style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view rvsa_known field uses plugin_id search_api_field_export"
