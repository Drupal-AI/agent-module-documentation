#!/usr/bin/env bash
# Execution VERIFY: PASS when field_settings has a field with property_path field_cfsapi_desc:title
# and type string. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fs = \Drupal::config("search_api.index.cfsapi_index")->get("field_settings") ?? [];
  $ok = FALSE; $seen = [];
  foreach ($fs as $k => $f) {
    $seen[] = ($f["property_path"] ?? "?").":".($f["type"] ?? "?");
    if (($f["property_path"] ?? "") === "field_cfsapi_desc:title" && ($f["type"] ?? "") === "string") { $ok = TRUE; }
  }
  print ($ok?"PASS":"FAIL")." fields=[".implode(",", $seen)."]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
