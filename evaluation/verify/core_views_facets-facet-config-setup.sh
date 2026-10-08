#!/usr/bin/env bash
# Introspection SETUP: build a node view (page display + exposed 'type' filter), then a Facets
# facet source using the REQUIRED core_views_url_processor, and a facet on the exposed 'type'
# filter. The agent inspects this live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  use Drupal\facets\Entity\Facet;
  use Drupal\facets\Entity\FacetSource;
  if (!View::load("cvf_eval_view")) {
    $display = [
      "default" => ["display_plugin"=>"default","id"=>"default","display_title"=>"Master","position"=>0,
        "display_options"=>[
          "access"=>["type"=>"perm","options"=>["perm"=>"access content"]],
          "cache"=>["type"=>"tag","options"=>[]],
          "query"=>["type"=>"views_query","options"=>[]],
          "exposed_form"=>["type"=>"basic","options"=>[]],
          "pager"=>["type"=>"none","options"=>["offset"=>0]],
          "style"=>["type"=>"default"],"row"=>["type"=>"fields"],
          "fields"=>["title"=>["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field","entity_type"=>"node","entity_field"=>"title"]],
          "filters"=>["type"=>["id"=>"type","table"=>"node_field_data","field"=>"type","relationship"=>"none","group_type"=>"group","admin_label"=>"","operator"=>"in","value"=>[],"group"=>1,"exposed"=>true,"expose"=>["operator_id"=>"type_op","label"=>"Type","use_operator"=>false,"operator"=>"type_op","identifier"=>"type","required"=>false,"remember"=>false,"multiple"=>false],"is_grouped"=>false,"entity_type"=>"node","entity_field"=>"type","plugin_id"=>"bundle"]],
          "sorts"=>[],"title"=>"CVF Eval"]],
      "page_1" => ["display_plugin"=>"page","id"=>"page_1","display_title"=>"Page","position"=>1,"display_options"=>["path"=>"cvf-eval","display_extenders"=>[]]],
    ];
    View::create(["id"=>"cvf_eval_view","label"=>"CVF Eval","base_table"=>"node_field_data","base_field"=>"nid","module"=>"views","display"=>$display])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\facets\Entity\Facet;
  use Drupal\facets\Entity\FacetSource;
  $srcId = "core_views_exposed_filter__cvf_eval_view__page_1";
  if (!FacetSource::load($srcId)) {
    FacetSource::create(["id"=>$srcId,"name"=>"core_views_exposed_filter:cvf_eval_view__page_1","filter_key"=>"f","url_processor"=>"core_views_url_processor"])->save();
  }
  if (!Facet::load("cvf_eval_facet")) {
    Facet::create(["id"=>"cvf_eval_facet","name"=>"CVF Eval Facet","url_alias"=>"type","facet_source_id"=>"core_views_exposed_filter:cvf_eval_view__page_1","field_identifier"=>"type","query_operator"=>"or","widget"=>["type"=>"links","config"=>["show_numbers"=>true]],"weight"=>0])->save();
  }
' >/dev/null 2>&1
echo "setup: view cvf_eval_view + facet source (core_views_url_processor) + facet cvf_eval_facet (field=type)"
