#!/usr/bin/env bash
# Execution VERIFY: PASS when log_stdout.settings use_stderr is truthy ('1'/1), i.e. warnings
# and errors are routed to stderr. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("log_stdout.settings")->get("use_stderr");
  $ok = ((string) $v === "1");
  print ($ok ? "PASS" : "FAIL") . " use_stderr=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
