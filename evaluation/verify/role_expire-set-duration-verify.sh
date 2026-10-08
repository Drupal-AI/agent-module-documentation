#!/usr/bin/env bash
# Execution VERIFY: PASS when role_expire.config default duration for re_task === '1 year'.
# Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("role_expire.config")->get("role_expire_default_duration_roles") ?: [];
  $v = $d["re_task"] ?? NULL;
  print (($v === "1 year") ? "PASS" : "FAIL") . " re_task=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
