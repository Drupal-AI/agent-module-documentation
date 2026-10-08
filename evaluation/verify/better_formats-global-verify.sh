#!/usr/bin/env bash
# Execution VERIFY: PASS when global "Use field default" (per_field_core) is TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("better_formats.settings")->get("per_field_core");
  print (($v === TRUE) ? "PASS" : "FAIL") . " per_field_core=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
