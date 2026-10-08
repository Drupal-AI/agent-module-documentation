#!/usr/bin/env bash
# Execution VERIFY: PASS when ape.settings lifetime.404 == 300. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("ape.settings")->get("lifetime.404");
  $ok = ($v !== NULL && $v !== "" && (int) $v === 300);
  print ($ok ? "PASS" : "FAIL") . " lifetime.404=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
