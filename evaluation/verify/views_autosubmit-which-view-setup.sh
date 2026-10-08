#!/usr/bin/env bash
# Introspection SETUP: two views, va_auto (autosubmit exposed form) and va_basic (basic
# exposed form). Agent must state which one uses autosubmit.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  foreach (["va_auto","va_basic"] as $id) { if ($v = View::load($id)) { $v->delete(); } }
  View::create([
    "id"=>"va_auto","label"=>"VA Auto","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["exposed_form"=>["type"=>"autosubmit","options"=>["autosubmit_hide"=>TRUE,"timeout"=>500]]]]],
  ])->save();
  View::create([
    "id"=>"va_basic","label"=>"VA Basic","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["exposed_form"=>["type"=>"basic","options"=>[]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: va_auto=autosubmit, va_basic=basic"
