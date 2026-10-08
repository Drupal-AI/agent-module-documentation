#!/usr/bin/env bash
# Execution VERIFY: PASS when all three property-type terms exist in the real_estate vocab. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $need = ["Condo","Multi-Family","Residential"]; $have = 0;
  foreach ($need as $name) {
    $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("vid","real_estate")->condition("name",$name)->execute();
    if ($ids) { $have++; }
  }
  $ok = ($have === 3);
  print ($ok ? "PASS" : "FAIL") . " have=$have/3\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
