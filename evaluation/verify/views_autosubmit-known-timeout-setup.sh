#!/usr/bin/env bash
# Introspection SETUP: create a view va_known whose default display uses the autosubmit
# exposed form with timeout=1200 and autosubmit_hide=false, so an agent can read the value.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("va_known")) { $v->delete(); }
  View::create([
    "id"=>"va_known","label"=>"VA Known","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>[
        "exposed_form"=>["type"=>"autosubmit","options"=>["autosubmit_hide"=>FALSE,"timeout"=>1200]],
        "pager"=>["type"=>"mini"],
      ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view va_known uses autosubmit exposed form, timeout=1200"
