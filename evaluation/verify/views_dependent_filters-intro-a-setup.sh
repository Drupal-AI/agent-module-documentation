#!/usr/bin/env bash
# Introspection SETUP: create a view vdf_intro_a whose exposed filters include a
# "Global: Dependent filter" (views_dependent_filter) with controller=type, dependent=title.
# Agent inspects views.view.vdf_intro_a to answer which filter controls which. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vdf_intro_a")) { $v->delete(); }
  $filters = [
    "type" => ["id"=>"type","table"=>"node_field_data","field"=>"type","plugin_id"=>"bundle","entity_type"=>"node","entity_field"=>"type","operator"=>"in","value"=>[],"exposed"=>TRUE,"expose"=>["operator_id"=>"type_op","label"=>"Type","identifier"=>"type","multiple"=>FALSE,"required"=>FALSE]],
    "views_dependent_filter" => ["id"=>"views_dependent_filter","table"=>"views","field"=>"views_dependent_filter","plugin_id"=>"views_dependent_filter","exposed"=>TRUE,"condition"=>"values","controller_filter"=>"type","controller_values"=>["article"=>"article"],"dependent_filters"=>["title"=>"title"],"negate"=>FALSE],
    "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"string","entity_type"=>"node","entity_field"=>"title","operator"=>"contains","value"=>"","exposed"=>TRUE,"expose"=>["operator_id"=>"title_op","label"=>"Title","identifier"=>"title","required"=>FALSE]],
  ];
  View::create(["id"=>"vdf_intro_a","label"=>"VDF Intro A","base_table"=>"node_field_data","base_field"=>"nid","display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,"display_options"=>["filters"=>$filters]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vdf_intro_a has Dependent filter controller=type dependent=title"
