#!/usr/bin/env bash
# Execution VERIFY: PASS when commerce_cart_redirection.settings has clear_cart_before_add === TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("commerce_cart_redirection.settings")->get("clear_cart_before_add");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " clear_cart_before_add=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
