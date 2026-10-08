#!/usr/bin/env bash
# Execution VERIFY: PASS when quiz.settings has_timer is TRUE (global quiz timer enabled).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("quiz.settings")->get("has_timer");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " has_timer=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
