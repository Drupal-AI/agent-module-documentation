#!/usr/bin/env bash
# Execution VERIFY: PASS when micon_local_task.config icon_only === TRUE. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("micon_local_task.config")->get("icon_only");
  print (($v === TRUE) ? "PASS" : "FAIL") . " icon_only=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
