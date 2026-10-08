#!/usr/bin/env bash
# Execution VERIFY: PASS when node__field_crf_task:field_crf_task_value is registered as a numeric
# contextual range filter in contextual_range_filter.settings. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = (array) (\Drupal::config("contextual_range_filter.settings")->get("numeric_field_names") ?? []);
  $ok = in_array("node__field_crf_task:field_crf_task_value", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " numeric_field_names=" . implode(",", $list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
