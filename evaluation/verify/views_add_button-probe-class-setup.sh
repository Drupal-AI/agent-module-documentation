#!/usr/bin/env bash
# Introspection SETUP: create a View vab_probe2 with an Entity Add Button area targeting node+page
# and a distinctive button_classes "vab-cta-button", so an agent can read the CSS classes back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vab_probe2")) { $v->delete(); }
  View::create([
    "id"=>"vab_probe2","label"=>"VAB Probe 2","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["footer"=>["views_add_button"=>[
        "id"=>"views_add_button","table"=>"views","field"=>"views_add_button","plugin_id"=>"views_add_button_area",
        "type"=>"node+page","button_text"=>"New Page","button_classes"=>"vab-cta-button","destination"=>true,"tokenize"=>false,
      ]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vab_probe2 footer add button classes=vab-cta-button"
