#!/usr/bin/env bash
# Execution VERIFY for "add a facet on the core-views facet source for the cvf_eval_view exposed
# 'type' filter". PASS when a facets_facet exists whose facet_source_id is a core_views facet
# source for cvf_eval_view__page_1 and whose field_identifier is 'type'. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $facets = \Drupal::entityTypeManager()->getStorage("facets_facet")->loadMultiple();
  $hit = NULL;
  foreach ($facets as $f) {
    $src = (string) $f->getFacetSourceId();
    if (strpos($src, "core_views_exposed_filter:cvf_eval_view__page_1") === 0 && $f->getFieldIdentifier() === "type") {
      $hit = $f; break;
    }
  }
  if ($hit) { print "PASS id=" . $hit->id() . " source=" . $hit->getFacetSourceId() . " field=" . $hit->getFieldIdentifier() . "\n"; }
  else { print "FAIL no facet on core_views source cvf_eval_view__page_1 with field_identifier=type\n"; }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
