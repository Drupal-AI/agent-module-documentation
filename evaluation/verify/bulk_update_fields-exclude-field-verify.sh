#!/usr/bin/env bash
# Execution VERIFY: PASS when field_buf_task is in bulk_update_fields.settings:exclude.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("bulk_update_fields.settings")->get("exclude") ?: [];
  print in_array("field_buf_task", $e, TRUE) ? "PASS" : "FAIL";
  print " exclude=" . implode(",", $e) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
