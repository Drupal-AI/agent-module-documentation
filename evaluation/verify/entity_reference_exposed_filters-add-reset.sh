#!/usr/bin/env bash
# Execution RESET: create a base View eref_eval on node_field_data WITHOUT the eref_node_titles
# filter, so verify FAILS until the agent adds it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("eref_eval")) { $v->delete(); }
  View::create([
    "id"=>"eref_eval","label"=>"EREF Eval","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["filters"=>[]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.eref_eval created WITHOUT eref_node_titles filter"
