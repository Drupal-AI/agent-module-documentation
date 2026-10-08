#!/usr/bin/env bash
# Execution VERIFY for "set the Thunderforest API key lmm-verify-key-42 so it's threaded into
# the Thunderforest tile URLs". PASS when a fresh call to hook_leaflet_map_info() returns an
# osm-cycle urlTemplate containing "?apikey=lmm-verify-key-42". Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
out=$(drush php:eval '
  $map_info = \Drupal::moduleHandler()->invokeAll("leaflet_map_info");
  \Drupal::moduleHandler()->alter("leaflet_map_info", $map_info);
  $url = $map_info["osm-cycle"]["layers"]["layer"]["urlTemplate"] ?? "";
  $ok = (strpos($url, "?apikey=lmm-verify-key-42") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " url=" . $url . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
