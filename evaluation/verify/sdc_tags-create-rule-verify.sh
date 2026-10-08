#!/usr/bin/env bash
# Execution VERIFY: PASS when the sdc_tags rule for tag 'sdct_task' allow-lists
# cl_editorial:component-card and has at least one permitted status. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("sdc_tags.settings")->get("component_tags.sdct_task");
  $allowed = is_array($c) ? ($c["allowed"] ?? []) : [];
  $statuses = is_array($c) ? ($c["statuses"] ?? []) : [];
  $ok = in_array("cl_editorial:component-card", $allowed, TRUE) && !empty($statuses);
  print ($ok ? "PASS" : "FAIL") . " allowed=" . json_encode($allowed) . " statuses=" . json_encode($statuses) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
