#!/usr/bin/env bash
# Live-state verification: genpass.settings:genpass_length is 32.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $len = (int) \Drupal::config("genpass.settings")->get("genpass_length");
  print ($len === 32 ? "PASS" : "FAIL") . " genpass_length=" . $len . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
