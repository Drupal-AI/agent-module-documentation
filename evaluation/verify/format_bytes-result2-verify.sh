#!/usr/bin/env bash
# Execution VERIFY: PASS when state format_bytes_eval.result2 === "5 MB" (format_bytes of
# 5242880). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::state()->get("format_bytes_eval.result2");
  print (trim($v) === "5 MB" ? "PASS" : "FAIL") . " result=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
