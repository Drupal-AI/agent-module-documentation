#!/usr/bin/env bash
# Execution VERIFY for "enable leaflet_demo and assemble a leaflet_more_maps custom map named
# 'LMM Demo Verify Combo' (Google satellite layer + OpenTopoMap layer) so it would appear on
# the demo showcase". PASS when leaflet_demo is enabled AND a fresh hook_leaflet_map_info()
# call returns a map keyed "~LMM Demo Verify Combo" with both expected layers. Prints
# PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
enabled=$(drush pm:list --status=enabled --field=name 2>/dev/null | grep -x 'leaflet_demo' || true)
out=$(drush php:eval '
  $map_info = \Drupal::moduleHandler()->invokeAll("leaflet_map_info");
  \Drupal::moduleHandler()->alter("leaflet_map_info", $map_info);
  $key = "~LMM Demo Verify Combo";
  $layers = $map_info[$key]["layers"] ?? [];
  $has_sat = FALSE;
  $has_topo = FALSE;
  foreach (array_keys($layers) as $label_key) {
    if (stripos($label_key, "Google satellite layer") !== FALSE) { $has_sat = TRUE; }
    if (stripos($label_key, "OpenTopoMap layer") !== FALSE) { $has_topo = TRUE; }
  }
  $ok = isset($map_info[$key]) && $has_sat && $has_topo;
  print ($ok ? "MAPOK" : "MAPFAIL") . " present=" . (isset($map_info[$key]) ? "yes" : "no") . " layers=" . implode("|", array_keys($layers)) . "\n";
' 2>/dev/null)
echo "module_enabled=${enabled:-no} $out"
if [ -n "$enabled" ] && echo "$out" | grep -q '^MAPOK'; then
  echo "PASS"
  exit 0
else
  echo "FAIL"
  exit 1
fi
