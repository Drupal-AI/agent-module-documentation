#!/usr/bin/env bash
# Execution VERIFY: PASS when State drd_agent.debug_mode is truthy (TRUE/1).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("drd_agent.debug_mode");
  print (($v == TRUE) ? "PASS" : "FAIL")." debug_mode=".var_export($v, TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
