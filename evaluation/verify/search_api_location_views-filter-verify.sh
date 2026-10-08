#!/usr/bin/env bash
# Execution VERIFY: PASS when the salv_loc field on index salv_index exposes the
# search_api_location Views filter (i.e. the field is typed 'location'). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("views.views_data")->clear();
  $d = \Drupal::service("views.views_data")->get("search_api_index_salv_index");
  $id = $d["salv_loc"]["filter"]["id"] ?? "none";
  print (($id === "search_api_location") ? "PASS" : "FAIL") . " salv_loc.filter.id=" . $id . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
