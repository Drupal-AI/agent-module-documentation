#!/usr/bin/env bash
# Execution VERIFY: PASS when pwa.config start_url === '/home'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("pwa.config")->get("start_url");
  print (($v === "/home") ? "PASS" : "FAIL") . " start_url=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
