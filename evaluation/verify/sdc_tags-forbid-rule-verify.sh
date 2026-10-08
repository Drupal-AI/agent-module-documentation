#!/usr/bin/env bash
# Execution VERIFY: PASS when the sdc_tags rule for tag 'sdct_forbid' forbids
# cl_editorial:component-card, keeps the allow-list empty (all-except-forbidden mode), and permits
# at least one status. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("sdc_tags.settings")->get("component_tags.sdct_forbid");
  $allowed = is_array($c) ? ($c["allowed"] ?? []) : [];
  $forbidden = is_array($c) ? ($c["forbidden"] ?? []) : [];
  $statuses = is_array($c) ? ($c["statuses"] ?? []) : [];
  $ok = in_array("cl_editorial:component-card", $forbidden, TRUE) && empty($allowed) && !empty($statuses);
  print ($ok ? "PASS" : "FAIL") . " forbidden=" . json_encode($forbidden) . " allowed=" . json_encode($allowed) . " statuses=" . json_encode($statuses) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
