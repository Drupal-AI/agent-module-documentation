#!/usr/bin/env bash
# Execution VERIFY: PASS when index sal_test_index field sal_loc uses the 'location' data type.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api\Entity\Index;
  $i = Index::load("sal_test_index");
  $t = ($i && $i->getField("sal_loc")) ? $i->getField("sal_loc")->getType() : "none";
  print (($t === "location") ? "PASS" : "FAIL") . " sal_loc.type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
