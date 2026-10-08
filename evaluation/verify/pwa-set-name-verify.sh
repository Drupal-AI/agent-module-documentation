#!/usr/bin/env bash
# Execution VERIFY: PASS when pwa.config name==='My PWA App' and short_name==='MyPWA'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("pwa.config");
  $n = $c->get("name"); $s = $c->get("short_name");
  $ok = ($n === "My PWA App" && $s === "MyPWA");
  print ($ok ? "PASS" : "FAIL") . " name=" . var_export($n, TRUE) . " short_name=" . var_export($s, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
