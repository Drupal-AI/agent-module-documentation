#!/usr/bin/env bash
# Execution VERIFY: PASS when the TacJS banner is switched off, i.e. tacjs.settings enabled === FALSE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("tacjs.settings")->get("enabled");
  print (($v === FALSE) ? "PASS" : "FAIL") . " enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
