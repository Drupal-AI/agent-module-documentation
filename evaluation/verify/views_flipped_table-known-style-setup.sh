#!/usr/bin/env bash
# Introspection SETUP: create view 'vft_demo' whose default display uses the flipped_table
# style, so an agent can read back the style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v=View::load("vft_demo")) { $v->delete(); }
  View::create([
    "id"=>"vft_demo","label"=>"VFT Demo","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "style"=>["type"=>"flipped_table","options"=>["flipped_table_header_first_field"=>true]],
        "row"=>["type"=>"fields"],
        "fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"]],
      ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vft_demo uses flipped_table style"
