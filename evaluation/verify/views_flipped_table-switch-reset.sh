#!/usr/bin/env bash
# Execution RESET: create view 'vft_task' with the CORE 'table' style (NOT flipped_table), so
# verify fails until the agent switches its style to flipped_table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v=View::load("vft_task")) { $v->delete(); }
  View::create([
    "id"=>"vft_task","label"=>"VFT Task","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "style"=>["type"=>"table","options"=>[]],
        "row"=>["type"=>"fields"],
        "fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"]],
      ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vft_task uses core table style"
