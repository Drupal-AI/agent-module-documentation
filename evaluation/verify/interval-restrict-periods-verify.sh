#!/usr/bin/env bash
# Execution VERIFY for "restrict field_interval_limit's widget to only Days and Weeks".
# PASS when the interval_default widget's allowed_periods (unchecked values filtered out)
# is exactly {day, week}. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $c = $fd->getComponent("field_interval_limit");
  $ap = $c["settings"]["allowed_periods"] ?? [];
  $keys = array_values(array_filter(array_keys(array_filter($ap))));
  sort($keys);
  $ok = ($keys === ["day", "week"]);
  print ($ok ? "PASS" : "FAIL") . " allowed=[" . implode(",", $keys) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
