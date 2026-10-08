#!/usr/bin/env bash
# Execution VERIFY: PASS when role_hierarchy.settings strict === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("role_hierarchy.settings")->get("strict");
  print (($v === TRUE || $v === 1 || $v === "1") ? "PASS" : "FAIL") . " strict=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
