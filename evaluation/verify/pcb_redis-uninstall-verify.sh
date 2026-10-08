#!/usr/bin/env bash
# Execution VERIFY: PASS when pcb_redis is NOT installed AND cache.backend.permanent_redis is NOT
# registered. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mod = \Drupal::moduleHandler()->moduleExists("pcb_redis");
  $svc = \Drupal::hasService("cache.backend.permanent_redis");
  $ok = (!$mod && !$svc);
  print ($ok ? "PASS" : "FAIL") . " module=" . var_export($mod, TRUE) . " service=" . var_export($svc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
