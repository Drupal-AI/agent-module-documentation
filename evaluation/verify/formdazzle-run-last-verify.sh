#!/usr/bin/env bash
# Execution VERIFY: PASS when formdazzle's module weight in core.extension is 10 (its shipped
# 'run last' weight, set by formdazzle_install). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("core.extension")->get("module.formdazzle");
  $ok = ((int) $w === 10);
  print ($ok?"PASS":"FAIL")." weight=".var_export($w,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
