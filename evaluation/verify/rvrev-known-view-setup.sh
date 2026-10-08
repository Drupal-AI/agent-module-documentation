#!/usr/bin/env bash
# Introspection SETUP: REST export view rvr_known whose serializable field uses the
# entity_reference_revisions_export formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("rvr_known")) { $v->delete(); }
  View::create([
    "id"=>"rvr_known","label"=>"RVR Known","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>["nid"=>["id"=>"nid","table"=>"node_field_data","field"=>"nid","plugin_id"=>"field_export","type"=>"entity_reference_revisions_export","entity_type"=>"node","entity_field"=>"nid"]],
        "style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]],
      "rest_export_1"=>["display_plugin"=>"rest_export","id"=>"rest_export_1","display_title"=>"REST export","position"=>1,
        "display_options"=>["path"=>"rvr-known","style"=>["type"=>"serializer"],"row"=>["type"=>"data_field"]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view rvr_known field uses entity_reference_revisions_export"
