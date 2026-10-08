#!/usr/bin/env bash
# Execution VERIFY: PASS when memory_limit_policy.settings:header === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$v = \Drupal::config("memory_limit_policy.settings")->get("header");
print (($v === TRUE) ? "PASS" : "FAIL") . " header=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
