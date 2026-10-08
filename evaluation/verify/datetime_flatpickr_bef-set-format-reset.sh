#!/usr/bin/env bash
# Execution RESET: view dtf_bef_view2 with created bef_flatpickr widget, dateFormat Y-m-d.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\views\Entity\View;
  if ($v = View::load("dtf_bef_view2")) { $v->delete(); }
  $display_options = [
    "fields" => ["title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"]],
    "filters" => ["created" => ["id"=>"created","table"=>"node_field_data","field"=>"created","plugin_id"=>"date","entity_type"=>"node","entity_field"=>"created","operator"=>">","value"=>["type"=>"date","value"=>""],"exposed"=>true,"expose"=>["operator_id"=>"created_op","label"=>"Created","identifier"=>"created","use_operator"=>false,"operator"=>"created_op","required"=>false,"multiple"=>false]]],
    "exposed_form" => ["type"=>"bef","options"=>["submit_button"=>"Apply","reset_button"=>false,"reset_button_label"=>"Reset","exposed_sorts_label"=>"Sort by","expose_sort_order"=>true,"sort_asc_label"=>"Asc","sort_desc_label"=>"Desc","input_required"=>false,"text_input_required"=>"Select","text_input_required_format"=>"basic_html","bef"=>["general"=>["autosubmit"=>false,"autosubmit_exclude_textfield"=>false,"autosubmit_textfield_delay"=>500,"autosubmit_hide"=>false,"input_required"=>false,"allow_secondary"=>false,"secondary_label"=>"Advanced","secondary_open"=>false,"reset_button_always_show"=>false],"filter"=>["created"=>["plugin_id"=>"bef_flatpickr","advanced"=>["collapsible"=>false,"collapsible_label"=>"","is_secondary"=>false],"dateFormat"=>"Y-m-d"]]]]],
    "pager" => ["type"=>"mini","options"=>["items_per_page"=>10]],
  ];
  $v = View::create(["id"=>"dtf_bef_view2","label"=>"DTF BEF View","base_table"=>"node_field_data","base_field"=>"nid","display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,"display_options"=>$display_options]]]);
  $v->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: dtf_bef_view2 bef_flatpickr dateFormat=Y-m-d"
