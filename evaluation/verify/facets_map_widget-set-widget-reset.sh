#!/usr/bin/env bash
# Execution RESET: create facet salf_heatmap using a plain 'links' widget (NOT the map widget),
# so verify FAILS until the agent switches it to the rpt heatmap widget. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("facets_facet");
  if ($o = $s->load("salf_heatmap")) $o->delete();
  $s->create([
    "id"=>"salf_heatmap","name"=>"SALF Heatmap","url_alias"=>"salf_heatmap",
    "facet_source_id"=>"search_api:views_page__salf_dummy__page_1",
    "field_identifier"=>"salf_rpt","query_operator"=>"or",
    "widget"=>["type"=>"links","config"=>["show_numbers"=>FALSE]],
    "processor_configs"=>[],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: facet salf_heatmap uses widget=links (not the map heatmap widget)"
