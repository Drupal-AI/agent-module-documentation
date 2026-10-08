#!/usr/bin/env bash
# VERIFY: PASS when ip_anon.settings policy===1 and period_watchdog===604800.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ip_anon.settings");
  $p = $c->get("policy"); $w = $c->get("period_watchdog");
  $ok = ((int)$p === 1 && (int)$w === 604800);
  print ($ok ? "PASS" : "FAIL") . " policy=" . var_export($p, TRUE) . " period_watchdog=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
