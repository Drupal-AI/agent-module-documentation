#!/usr/bin/env bash
# Execution VERIFY: PASS when the depcalc cache bin is EMPTY (the depcalc_ui clear action, or
# its equivalent deleteAllPermanent / drush depcalc:clear-cache, was performed).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = (int) \Drupal::database()->query("SELECT COUNT(*) FROM {cache_depcalc}")->fetchField();
  print ($n === 0 ? "PASS" : "FAIL")." rows=".$n."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
