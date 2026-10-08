#!/usr/bin/env bash
# Execution VERIFY: PASS when BOTH field_buf_x and field_buf_y are in the exclude list.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("bulk_update_fields.settings")->get("exclude") ?: [];
  $ok = in_array("field_buf_x", $e, TRUE) && in_array("field_buf_y", $e, TRUE);
  print $ok ? "PASS" : "FAIL";
  print " exclude=" . implode(",", $e) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
