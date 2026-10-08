#!/usr/bin/env bash
# Execution VERIFY: PASS when import_rows_per_batch == 50. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (int) \Drupal::config("paragraphs_report.settings")->get("import_rows_per_batch");
  print (($v === 50) ? "PASS" : "FAIL") . " import_rows_per_batch=" . $v . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
