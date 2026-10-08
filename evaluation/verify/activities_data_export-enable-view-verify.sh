#!/usr/bin/env bash
# Execution VERIFY: PASS when the activity_log view is enabled (status true). exit 0 pass/1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("views.view.activity_log")->get("status");
  print (($s === TRUE) ? "PASS" : "FAIL") . " status=" . var_export($s, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
