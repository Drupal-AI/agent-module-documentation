#!/usr/bin/env bash
# Execution VERIFY: PASS when filter.format.oe_task_format has the obfuscate_email filter enabled
# (status true). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $status = \Drupal::config("filter.format.oe_task_format")->get("filters.obfuscate_email.status");
  $ok = ($status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
