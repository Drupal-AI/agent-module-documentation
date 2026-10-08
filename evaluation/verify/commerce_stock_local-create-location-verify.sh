#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_stock_location named 'CSL West Warehouse' exists.
# Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_stock_location")->getQuery()
    ->accessCheck(FALSE)->condition("name", "CSL West Warehouse")->execute();
  $n = count($ids);
  print (($n > 0) ? "PASS" : "FAIL") . " locations_named=" . $n . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
