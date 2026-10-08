#!/usr/bin/env bash
# Execution VERIFY: PASS when a published real_estate entity named 'SGM Task Estate' exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\styled_google_map_demo\Entity\RealEstate;
  $ids = \Drupal::entityQuery("real_estate")->accessCheck(FALSE)->condition("name","SGM Task Estate")->execute();
  $ok = FALSE;
  foreach ($ids as $id) { if ($e = RealEstate::load($id)) { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " count=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
