#!/usr/bin/env bash
# Execution VERIFY: PASS when search_api.index.cfsapi_index field_settings has a field whose
# property_path is field_cfsapi_desc:body with type text. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fs = \Drupal::config("search_api.index.cfsapi_index")->get("field_settings") ?? [];
  $ok = FALSE; $seen = [];
  foreach ($fs as $k => $f) {
    $seen[] = ($f["property_path"] ?? "?").":".($f["type"] ?? "?");
    if (($f["property_path"] ?? "") === "field_cfsapi_desc:body" && ($f["type"] ?? "") === "text") { $ok = TRUE; }
  }
  print ($ok?"PASS":"FAIL")." fields=[".implode(",", $seen)."]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
