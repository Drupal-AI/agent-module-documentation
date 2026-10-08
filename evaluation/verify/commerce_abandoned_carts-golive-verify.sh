#!/usr/bin/env bash
# Execution VERIFY: PASS when timeout==4320 AND testmode is disabled (falsy).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("commerce_abandoned_carts.settings");
  $t = $c->get("timeout"); $tm = $c->get("testmode");
  $ok = ((int) $t === 4320) && empty($tm);
  print ($ok ? "PASS" : "FAIL") . " timeout=" . var_export($t, TRUE) . " testmode=" . var_export($tm, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
