#!/usr/bin/env bash
# Execution VERIFY: PASS when activities is configured to log BOTH node create and node delete
# (their config values are non-zero). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = \Drupal::config("activities.settings")->get("node") ?? [];
  $ok = !empty($n["create"]) && !empty($n["delete"]);
  print (($ok) ? "PASS" : "FAIL") . " create=" . var_export($n["create"] ?? NULL, TRUE) . " delete=" . var_export($n["delete"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
