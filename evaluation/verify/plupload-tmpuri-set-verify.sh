#!/usr/bin/env bash
# Execution VERIFY: PASS when plupload.settings temporary_uri === 'private://plupload_pl_hard'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("plupload.settings")->get("temporary_uri");
  print (($v === "private://plupload_pl_hard") ? "PASS" : "FAIL") . " temporary_uri=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
