#!/usr/bin/env bash
# Execution VERIFY: PASS when global dedupe is set to Strict (2). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (int) \Drupal::config("filehash.settings")->get("dedupe");
  print (($v === 2) ? "PASS" : "FAIL") . " dedupe=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
