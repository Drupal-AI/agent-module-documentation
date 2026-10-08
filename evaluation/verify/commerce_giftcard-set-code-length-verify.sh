#!/usr/bin/env bash
# Execution VERIFY: PASS when gift-card type cg_len has generate.length == 20. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $len = \Drupal::config("commerce_giftcard.giftcard_type.cg_len")->get("generate.length");
  $ok = ((int) $len === 20);
  print ($ok ? "PASS" : "FAIL") . " length=" . var_export($len, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
