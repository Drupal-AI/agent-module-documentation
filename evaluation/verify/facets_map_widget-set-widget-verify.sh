#!/usr/bin/env bash
# Execution VERIFY: PASS when facet salf_heatmap uses the rpt (interactive map heatmap) widget.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("facets_facet")->load("salf_heatmap");
  $w = $f ? ($f->getWidget()["type"] ?? "none") : "missing";
  print (($w === "rpt") ? "PASS" : "FAIL") . " widget=" . $w . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
