#!/usr/bin/env bash
# VERIFY: PASS when ip_anon.settings policy===1 and period_sessions===3600.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ip_anon.settings");
  $p = $c->get("policy"); $s = $c->get("period_sessions");
  $ok = ((int)$p === 1 && (int)$s === 3600);
  print ($ok ? "PASS" : "FAIL") . " policy=" . var_export($p, TRUE) . " period_sessions=" . var_export($s, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
