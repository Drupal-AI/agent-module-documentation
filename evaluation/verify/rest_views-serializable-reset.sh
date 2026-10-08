#!/usr/bin/env bash
# Execution RESET: REST export view rv_task whose 'title' field uses the CORE Views field
# handler (plugin_id 'field'), so verify FAILS until the agent switches it to field_export.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("rv_task")) { $v->delete(); }
  View::create([
    "id"=>"rv_task","label"=>"RV Task","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>[
      "display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>[
        "fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","type"=>"string","entity_type"=>"node","entity_field"=>"title"]],
        "style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"],
      ]],
      "rest_export_1"=>["display_plugin"=>"rest_export","id"=>"rest_export_1","display_title"=>"REST export","position"=>1,
        "display_options"=>["path"=>"rv-task","style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view rv_task title field uses core 'field' handler (not serializable)"
