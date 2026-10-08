#!/usr/bin/env bash
# Execution VERIFY: PASS when field_crf_toggle is NO LONGER registered as a numeric range filter
# (i.e. converted back to a plain contextual filter). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = (array) (\Drupal::config("contextual_range_filter.settings")->get("numeric_field_names") ?? []);
  $ok = !in_array("node__field_crf_toggle:field_crf_toggle_value", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " numeric_field_names=" . implode(",", $list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
