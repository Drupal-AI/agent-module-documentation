#!/usr/bin/env bash
# Execution VERIFY: PASS when a term 'SGM Task Type' exists in the real_estate vocabulary. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("vid","real_estate")->condition("name","SGM Task Type")->execute();
  $ok = (bool) $ids;
  print ($ok ? "PASS" : "FAIL") . " count=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
