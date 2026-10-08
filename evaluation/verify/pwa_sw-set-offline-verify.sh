#!/usr/bin/env bash
# Execution VERIFY: PASS when offline_page === '/sorry-offline'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("pwa_service_worker.config")->get("offline_page");
  print (($v === "/sorry-offline") ? "PASS" : "FAIL") . " offline_page=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
