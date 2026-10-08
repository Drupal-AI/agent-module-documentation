#!/usr/bin/env bash
# Execution VERIFY: PASS when auditfiles maximum_records === 500. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("auditfiles.settings")->get("auditfiles_report_options_maximum_records");
  print (((int) $v === 500) ? "PASS" : "FAIL") . " maximum_records=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
