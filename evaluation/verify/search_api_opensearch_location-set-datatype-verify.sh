#!/usr/bin/env bash
# Execution VERIFY: PASS when the field_saol_geo field on index saol_task has data type
# 'location'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fs = \Drupal::config("search_api.index.saol_task")->get("field_settings");
  $type = $fs["field_saol_geo"]["type"] ?? "none";
  $ok = ($type === "location");
  print ($ok?"PASS":"FAIL")." type=".$type."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
