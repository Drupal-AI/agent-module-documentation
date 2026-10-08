#!/usr/bin/env bash
# Execution VERIFY: PASS when ip2country.settings has debug=TRUE, test_type=0 (country spoof),
# and test_country='DE'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ip2country.settings");
  $ok = ($c->get("debug") === TRUE) && ((int) $c->get("test_type") === 0) && ($c->get("test_country") === "DE");
  print ($ok ? "PASS" : "FAIL")
    . " debug=" . var_export($c->get("debug"), TRUE)
    . " test_type=" . var_export($c->get("test_type"), TRUE)
    . " test_country=" . var_export($c->get("test_country"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
