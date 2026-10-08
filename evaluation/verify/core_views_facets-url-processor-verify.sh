#!/usr/bin/env bash
# Execution VERIFY for "set the facet source's URL processor to Core views url processor".
# PASS when facets.facet_source.core_views_exposed_filter__cvf_eval_view__page_1 has
# url_processor === core_views_url_processor. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("facets_facet_source")->load("core_views_exposed_filter__cvf_eval_view__page_1");
  $up = $s ? (string) $s->getUrlProcessorName() : "none";
  $ok = ($up === "core_views_url_processor");
  print ($ok ? "PASS" : "FAIL") . " url_processor=" . $up . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
