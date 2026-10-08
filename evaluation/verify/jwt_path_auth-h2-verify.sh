#!/usr/bin/env bash
# Execution VERIFY for "configure allowed_path_prefixes to exactly ['/downloads/']". PASS iff
# the array equals exactly ["/downloads/"]. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $prefixes = array_values((array) \Drupal::config("jwt_path_auth.config")->get("allowed_path_prefixes"));
  $ok = ($prefixes === ["/downloads/"]);
  print ($ok ? "PASS" : "FAIL") . " allowed_path_prefixes=" . json_encode($prefixes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
