#!/usr/bin/env bash
# Execution VERIFY: PASS when a currency entity QHC exists and is enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\currency\Entity\Currency;
  $c = Currency::load("QHC");
  $ok = $c && $c->status();
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $c, TRUE)
    . " enabled=" . var_export($c ? (bool) $c->status() : FALSE, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
