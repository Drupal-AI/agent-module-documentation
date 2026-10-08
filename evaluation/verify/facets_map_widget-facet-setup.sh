#!/usr/bin/env bash
# Introspection SETUP: create a Facets facet salf_heatmap that uses the facets_map_widget
# interactive-map heatmap widget (rpt) and its Facets Map Processor (rpt). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("facets_facet");
  if ($o = $s->load("salf_heatmap")) $o->delete();
  $s->create([
    "id"=>"salf_heatmap","name"=>"SALF Heatmap","url_alias"=>"salf_heatmap",
    "facet_source_id"=>"search_api:views_page__salf_dummy__page_1",
    "field_identifier"=>"salf_rpt","query_operator"=>"or",
    "widget"=>["type"=>"rpt","config"=>[]],
    "processor_configs"=>["rpt"=>["processor_id"=>"rpt","weights"=>[],"settings"=>[]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facet salf_heatmap uses widget rpt + rpt processor"
