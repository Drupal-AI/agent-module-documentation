#!/usr/bin/env bash
# HARD VERIFY: PASS when vgj_task_view has a display outputting GeoJSON: either a display with
# display_plugin geojson_export, or any display whose style type is 'geojson'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vgj_task_view"); $ok = FALSE; $how = "none";
  if ($v) {
    foreach ($v->get("display") as $d) {
      if (($d["display_plugin"] ?? "") === "geojson_export") { $ok = TRUE; $how = "display:".$d["id"]; break; }
      if (($d["display_options"]["style"]["type"] ?? "") === "geojson") { $ok = TRUE; $how = "style:".$d["id"]; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " " . $how . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
