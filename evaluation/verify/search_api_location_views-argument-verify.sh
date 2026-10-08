#!/usr/bin/env bash
# Execution VERIFY: PASS when some field on index salv_index exposes the
# search_api_location_point Views contextual filter (argument) - i.e. a location-typed field
# was added. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("views.views_data")->clear();
  $d = \Drupal::service("views.views_data")->get("search_api_index_salv_index");
  $found = "none";
  foreach ((array) $d as $k => $info) {
    if (isset($info["argument"]["id"]) && $info["argument"]["id"] === "search_api_location_point") { $found = $k; break; }
  }
  print (($found !== "none") ? "PASS" : "FAIL") . " point_argument_field=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
