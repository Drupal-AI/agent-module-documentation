#!/usr/bin/env bash
# Execution VERIFY: PASS when role fs3_task has the 'use S3 CORS upload' permission. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("user_role")->load("fs3_task");
  $ok = $r && $r->hasPermission("use S3 CORS upload");
  print ($ok ? "PASS" : "FAIL") . " role=" . var_export((bool)$r,TRUE) . " has_perm=" . var_export($r ? $r->hasPermission("use S3 CORS upload") : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
