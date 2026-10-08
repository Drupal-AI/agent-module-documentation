#!/usr/bin/env bash
# Execution VERIFY: PASS when facet salf_heatmap has the rpt (Facets Map) processor enabled.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("facets_facet")->load("salf_heatmap");
  $has = FALSE;
  if ($f) { $p = $f->getProcessorConfigs(); $has = isset($p["rpt"]); }
  print ($has ? "PASS" : "FAIL") . " rpt_processor=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
