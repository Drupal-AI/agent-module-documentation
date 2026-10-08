#!/usr/bin/env bash
# Execution VERIFY for "also allow /jwtpa-task/". PASS iff '/jwtpa-task/' is present in
# jwt_path_auth.config allowed_path_prefixes. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $prefixes = (array) \Drupal::config("jwt_path_auth.config")->get("allowed_path_prefixes");
  $ok = in_array("/jwtpa-task/", $prefixes, TRUE);
  print ($ok ? "PASS" : "FAIL") . " allowed_path_prefixes=" . json_encode($prefixes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
