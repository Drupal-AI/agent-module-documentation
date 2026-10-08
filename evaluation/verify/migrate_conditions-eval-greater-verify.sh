#!/usr/bin/env bash
# Execution VERIFY: PASS when State key migrate_conditions_task1 holds a truthy boolean (the
# correct evaluation of greater_than(3) against source value 5 is TRUE). Exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("migrate_conditions_task1");
  $ok = ($v !== NULL) && filter_var($v, FILTER_VALIDATE_BOOLEAN);
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
