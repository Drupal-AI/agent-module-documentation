#!/usr/bin/env bash
# Introspection SETUP: create a View vab_probe with a "Global: Entity Add Button" AREA in its
# header, targeting node+article, button_text "Add Article", so an agent can read the button text
# back from the view config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vab_probe")) { $v->delete(); }
  View::create([
    "id"=>"vab_probe","label"=>"VAB Probe","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["header"=>["views_add_button"=>[
        "id"=>"views_add_button","table"=>"views","field"=>"views_add_button","plugin_id"=>"views_add_button_area",
        "type"=>"node+article","button_text"=>"Add Article","button_classes"=>"button","destination"=>true,"tokenize"=>false,
      ]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vab_probe header has views_add_button_area (node+article, button_text=Add Article)"
