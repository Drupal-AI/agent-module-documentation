#!/usr/bin/env bash
# Execution RESET: create view va_conf that already uses the autosubmit exposed form but with
# autosubmit_hide=FALSE and timeout=500, so verify FAILS until the agent sets hide=TRUE and
# timeout=2500.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("va_conf")) { $v->delete(); }
  View::create([
    "id"=>"va_conf","label"=>"VA Conf","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["exposed_form"=>["type"=>"autosubmit","options"=>["autosubmit_hide"=>FALSE,"timeout"=>500]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view va_conf autosubmit with autosubmit_hide=FALSE, timeout=500"
