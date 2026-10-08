#!/usr/bin/env bash
# Execution RESET: create view va_task whose default display uses the 'basic' exposed form
# (NOT autosubmit), so verify FAILS until the agent switches it to autosubmit.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("va_task")) { $v->delete(); }
  View::create([
    "id"=>"va_task","label"=>"VA Task","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["exposed_form"=>["type"=>"basic","options"=>[]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view va_task uses basic exposed form (not autosubmit)"
