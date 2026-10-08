#!/usr/bin/env bash
# Execution RESET: REST export view rv_num whose 'nid' field already uses the serializable
# handler (field_export) but with a plain formatter (type 'number_integer'), so verify FAILS
# until the agent switches the formatter to number_export.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("rv_num")) { $v->delete(); }
  View::create([
    "id"=>"rv_num","label"=>"RV Num","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>[
      "display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>[
        "fields"=>["nid"=>["id"=>"nid","table"=>"node_field_data","field"=>"nid","plugin_id"=>"field_export","type"=>"number_integer","entity_type"=>"node","entity_field"=>"nid"]],
        "style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"],
      ]],
      "rest_export_1"=>["display_plugin"=>"rest_export","id"=>"rest_export_1","display_title"=>"REST export","position"=>1,
        "display_options"=>["path"=>"rv-num","style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view rv_num nid uses field_export handler with plain number_integer formatter"
