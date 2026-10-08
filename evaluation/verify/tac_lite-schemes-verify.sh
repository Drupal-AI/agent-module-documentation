#!/usr/bin/env bash
# Execution VERIFY: PASS when tac_lite is configured to use 2 (or more) schemes. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = (int) \Drupal::config("tac_lite.settings")->get("tac_lite_schemes");
  print (($n >= 2) ? "PASS" : "FAIL") . " tac_lite_schemes=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
