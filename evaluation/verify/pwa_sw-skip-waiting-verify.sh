#!/usr/bin/env bash
# Execution VERIFY: PASS when skip_waiting is truthy (TRUE). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("pwa_service_worker.config")->get("skip_waiting");
  print (($v === TRUE || $v === 1 || $v === "1") ? "PASS" : "FAIL") . " skip_waiting=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
