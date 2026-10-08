#!/usr/bin/env bash
# Execution VERIFY: PASS when public://cecsv_export.csv exists and contains the node title
# "Cecsv Hard Node" (proving a real CSV export of the cecsv_doc type was produced). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::service("file_system")->realpath("public://") . "/cecsv_export.csv";
  if (!file_exists($p)) { print "FAIL file missing $p\n"; }
  else {
    $c = file_get_contents($p);
    $ok = strpos($c, "Cecsv Hard Node") !== FALSE;
    print ($ok ? "PASS" : "FAIL") . " bytes=" . strlen($c) . " hasTitle=" . var_export($ok, TRUE) . "\n";
  }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
