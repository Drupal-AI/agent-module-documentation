#!/usr/bin/env bash
# Execution VERIFY: PASS when vendor_stream_wrapper.settings allowed_file_patterns contains the
# exact single-file pattern 'widgetco/lib/js/widget.js'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("vendor_stream_wrapper.settings")->get("allowed_file_patterns") ?? [];
  $ok = in_array("widgetco/lib/js/widget.js", $p, TRUE);
  print ($ok ? "PASS" : "FAIL") . " patterns=" . json_encode($p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
