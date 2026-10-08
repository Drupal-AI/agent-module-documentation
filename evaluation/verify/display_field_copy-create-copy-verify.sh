#!/usr/bin/env bash
# Execution VERIFY: PASS when a Display Suite dynamic field ds.field.dfc_task exists with
# type=display_field_copy and a non-empty properties.field_id. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ds.field.dfc_task")->get();
  $type = $c["type"] ?? "none";
  $fid = $c["properties"]["field_id"] ?? "";
  $ok = ($type === "display_field_copy" && $fid !== "");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " field_id=" . var_export($fid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
