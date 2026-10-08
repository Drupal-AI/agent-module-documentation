#!/usr/bin/env bash
# Introspection SETUP: REST export view rv_bool whose 'status' (published) field uses the
# serializable handler with the boolean_export formatter (real JSON boolean).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("rv_bool")) { $v->delete(); }
  View::create([
    "id"=>"rv_bool","label"=>"RV Bool","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>[
      "display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>[
        "fields"=>["status"=>["id"=>"status","table"=>"node_field_data","field"=>"status","plugin_id"=>"field_export","type"=>"boolean_export","entity_type"=>"node","entity_field"=>"status"]],
        "style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"],
      ]],
      "rest_export_1"=>["display_plugin"=>"rest_export","id"=>"rest_export_1","display_title"=>"REST export","position"=>1,
        "display_options"=>["path"=>"rv-bool","style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view rv_bool status field uses boolean_export formatter"
