#!/usr/bin/env bash
# Execution VERIFY: PASS when the default product variation type has the 'commerce_license'
# ("Provides a license") entity trait enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  $traits = $t ? $t->getTraits() : [];
  print (in_array("commerce_license", $traits, TRUE) ? "PASS" : "FAIL") . " traits=" . implode(",", $traits) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
