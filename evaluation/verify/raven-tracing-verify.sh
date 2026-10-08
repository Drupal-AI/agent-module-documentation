#!/usr/bin/env bash
# HARD execution verify: backend request tracing enabled, traces sample rate = 0.25,
# and database query tracing enabled. Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("raven.settings");
  $req = $c->get("request_tracing") === TRUE;
  $rate = (float) $c->get("traces_sample_rate") === 0.25;
  $db = $c->get("database_tracing") === TRUE;
  print (($req && $rate && $db) ? "PASS" : "FAIL") . " request_tracing=" . ($req?1:0) . " rate=" . var_export($c->get("traces_sample_rate"), TRUE) . " database_tracing=" . ($db?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
