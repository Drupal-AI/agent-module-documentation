#!/usr/bin/env bash
# Execution RESET (area): create a base View vab_view of content with NO Entity Add Button in its
# header/footer, so verify FAILS until the agent adds the views_add_button_area handler. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vab_view")) { $v->delete(); }
  View::create([
    "id"=>"vab_view","label"=>"VAB View","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["header"=>[],"footer"=>[],"fields"=>[]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: base view vab_view has no add button"
