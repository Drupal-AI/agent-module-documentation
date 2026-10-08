#!/usr/bin/env bash
# Execution VERIFY: PASS when State key migrate_conditions_task2 holds a truthy boolean. The
# correct evaluation of an 'and' of greater_than(4) and less_than(6) against 5 is TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("migrate_conditions_task2");
  $ok = ($v !== NULL) && filter_var($v, FILTER_VALIDATE_BOOLEAN);
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
