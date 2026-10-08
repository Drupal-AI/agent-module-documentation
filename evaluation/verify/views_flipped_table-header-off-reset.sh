#!/usr/bin/env bash
# Execution RESET: create view 'vft_task2' using flipped_table with
# flipped_table_header_first_field = TRUE, so verify (which needs it FALSE) fails until the
# agent turns the option off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v=View::load("vft_task2")) { $v->delete(); }
  View::create([
    "id"=>"vft_task2","label"=>"VFT Task2","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "style"=>["type"=>"flipped_table","options"=>["flipped_table_header_first_field"=>true]],
        "row"=>["type"=>"fields"],
        "fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"]],
      ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vft_task2 flipped_table, flipped_table_header_first_field=TRUE"
