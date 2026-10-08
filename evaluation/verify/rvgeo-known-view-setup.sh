#!/usr/bin/env bash
# Introspection SETUP: create a REST export view rvg_known whose field uses the rest_views_geo
# export formatter (geolocation_latlng_formatter_export) via the serializable handler.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("rvg_known")) { $v->delete(); }
  View::create([
    "id"=>"rvg_known","label"=>"RVG Known","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>["nid"=>["id"=>"nid","table"=>"node_field_data","field"=>"nid","plugin_id"=>"field_export","type"=>"geolocation_latlng_formatter_export","entity_type"=>"node","entity_field"=>"nid"]],
        "style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]],
      "rest_export_1"=>["display_plugin"=>"rest_export","id"=>"rest_export_1","display_title"=>"REST export","position"=>1,
        "display_options"=>["path"=>"rvg-known","style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view rvg_known field uses geolocation_latlng_formatter_export"
