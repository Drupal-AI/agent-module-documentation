#!/usr/bin/env bash
# Execution RESET: create REST export view rvg_task with a serializable field using a plain
# formatter (type 'string'), so verify FAILS until the agent sets the geo export formatter.
set -uo pipefail
cd /var/www/html
drush en rest_views_geo -y >/dev/null 2>&1
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("rvg_task")) { $v->delete(); }
  View::create([
    "id"=>"rvg_task","label"=>"RVG Task","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>["nid"=>["id"=>"nid","table"=>"node_field_data","field"=>"nid","plugin_id"=>"field_export","type"=>"string","entity_type"=>"node","entity_field"=>"nid"]],
        "style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]],
      "rest_export_1"=>["display_plugin"=>"rest_export","id"=>"rest_export_1","display_title"=>"REST export","position"=>1,
        "display_options"=>["path"=>"rvg-task","style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view rvg_task field uses plain formatter (not geo export)"
