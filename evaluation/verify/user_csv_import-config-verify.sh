#!/usr/bin/env bash
# Execution VERIFY: PASS when a saved import config sets default password 'Ucsv_Task_Pw!' and
# status Active ('1').
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("user_csv_import.importconfig");
  $pw = $c->get("password"); $st = $c->get("status");
  $ok = ($pw === "Ucsv_Task_Pw!") && ((string) $st === "1");
  print ($ok ? "PASS" : "FAIL") . " password=" . var_export($pw,true) . " status=" . var_export($st,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
