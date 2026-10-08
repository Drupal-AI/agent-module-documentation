#!/usr/bin/env bash
# Execution RESET: (re)create view vdf_exec_a with two EXPOSED filters (type, title) and NO
# Dependent filter handler, so verify FAILS until the agent adds one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vdf_exec_a")) { $v->delete(); }
  $filters = [
    "type" => ["id"=>"type","table"=>"node_field_data","field"=>"type","plugin_id"=>"bundle","entity_type"=>"node","entity_field"=>"type","operator"=>"in","value"=>[],"exposed"=>TRUE,"expose"=>["operator_id"=>"type_op","label"=>"Type","identifier"=>"type","multiple"=>FALSE,"required"=>FALSE]],
    "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"string","entity_type"=>"node","entity_field"=>"title","operator"=>"contains","value"=>"","exposed"=>TRUE,"expose"=>["operator_id"=>"title_op","label"=>"Title","identifier"=>"title","required"=>FALSE]],
  ];
  View::create(["id"=>"vdf_exec_a","label"=>"VDF Exec A","base_table"=>"node_field_data","base_field"=>"nid","display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,"display_options"=>["filters"=>$filters]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vdf_exec_a has exposed type + title, no Dependent filter"
