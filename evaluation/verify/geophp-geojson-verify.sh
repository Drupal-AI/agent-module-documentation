#!/usr/bin/env bash
# Execution VERIFY: PASS when Drupal state geophp_eval_geojson holds GeoJSON for POINT(5 5),
# i.e. a Point with coordinates [5,5]. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("geophp_eval_geojson");
  $ok = FALSE;
  if (is_string($v)) {
    $d = json_decode($v, TRUE);
    if (is_array($d) && strtolower($d["type"] ?? "") === "point"
        && isset($d["coordinates"]) && (float) $d["coordinates"][0] === 5.0 && (float) $d["coordinates"][1] === 5.0) {
      $ok = TRUE;
    }
  }
  print ($ok ? "PASS" : "FAIL") . " geophp_eval_geojson=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
