#!/usr/bin/env bash
# Execution VERIFY: PASS when a simple_mega_menu entity named 'SMM Promo' exists in bundle smm_ct.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("simple_mega_menu")
    ->loadByProperties(["type" => "smm_ct", "name" => "SMM Promo"]);
  $ok = !empty($e);
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($e) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
