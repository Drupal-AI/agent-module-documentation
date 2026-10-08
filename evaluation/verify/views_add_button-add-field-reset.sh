#!/usr/bin/env bash
# Execution RESET (field): create a base View vab_fview of content with NO Entity Add Button field,
# so verify FAILS until the agent adds the views_add_button_field handler. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vab_fview")) { $v->delete(); }
  View::create([
    "id"=>"vab_fview","label"=>"VAB Field View","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>[]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: base view vab_fview has no add button field"
