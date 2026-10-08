#!/usr/bin/env bash
# Execution VERIFY: PASS when vendor_stream_wrapper.settings allowed_file_patterns contains the
# pattern 'acmelib/build/css/*.css'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("vendor_stream_wrapper.settings")->get("allowed_file_patterns") ?? [];
  $ok = in_array("acmelib/build/css/*.css", $p, TRUE);
  print ($ok ? "PASS" : "FAIL") . " patterns=" . json_encode($p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
