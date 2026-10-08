#!/usr/bin/env bash
# Introspection SETUP: create view vdf_intro_b with a Dependent filter using condition mode
# "not_empty" and negate=true (controller=type, dependent=title). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vdf_intro_b")) { $v->delete(); }
  $filters = [
    "type" => ["id"=>"type","table"=>"node_field_data","field"=>"type","plugin_id"=>"bundle","entity_type"=>"node","entity_field"=>"type","operator"=>"in","value"=>[],"exposed"=>TRUE,"expose"=>["operator_id"=>"type_op","label"=>"Type","identifier"=>"type","multiple"=>FALSE,"required"=>FALSE]],
    "views_dependent_filter" => ["id"=>"views_dependent_filter","table"=>"views","field"=>"views_dependent_filter","plugin_id"=>"views_dependent_filter","exposed"=>TRUE,"condition"=>"not_empty","controller_filter"=>"type","controller_values"=>NULL,"dependent_filters"=>["title"=>"title"],"negate"=>TRUE],
    "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"string","entity_type"=>"node","entity_field"=>"title","operator"=>"contains","value"=>"","exposed"=>TRUE,"expose"=>["operator_id"=>"title_op","label"=>"Title","identifier"=>"title","required"=>FALSE]],
  ];
  View::create(["id"=>"vdf_intro_b","label"=>"VDF Intro B","base_table"=>"node_field_data","base_field"=>"nid","display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,"display_options"=>["filters"=>$filters]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vdf_intro_b Dependent filter controller=type condition=not_empty negate=true"
