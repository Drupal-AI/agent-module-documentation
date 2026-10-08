#!/usr/bin/env bash
# Execution VERIFY for "assemble a custom map named 'LMM Verify Combo' combining the Bing
# hybrid layer and the Esri World Imagery layer". PASS when a fresh call to
# hook_leaflet_map_info() returns a map keyed "~LMM Verify Combo" whose layers include both
# expected labels. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
out=$(drush php:eval '
  $map_info = \Drupal::moduleHandler()->invokeAll("leaflet_map_info");
  \Drupal::moduleHandler()->alter("leaflet_map_info", $map_info);
  $key = "~LMM Verify Combo";
  $layers = $map_info[$key]["layers"] ?? [];
  $has_bing = FALSE;
  $has_esri = FALSE;
  foreach (array_keys($layers) as $label_key) {
    if (stripos($label_key, "hybrid layer") !== FALSE) { $has_bing = TRUE; }
    if (stripos($label_key, "Esri World Imagery layer") !== FALSE) { $has_esri = TRUE; }
  }
  $ok = isset($map_info[$key]) && $has_bing && $has_esri;
  print ($ok ? "PASS" : "FAIL") . " present=" . (isset($map_info[$key]) ? "yes" : "no") . " layers=" . implode("|", array_keys($layers)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
