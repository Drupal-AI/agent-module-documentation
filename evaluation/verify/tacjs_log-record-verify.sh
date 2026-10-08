#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one tacjslog row records consent for service
# 'tacjs_log_task'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = \Drupal::database()->select("tacjslog","l")->condition("services_allowed","tacjs_log_task")->countQuery()->execute()->fetchField();
  print (($n > 0) ? "PASS" : "FAIL") . " rows=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
