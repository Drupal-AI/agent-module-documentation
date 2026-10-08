#!/usr/bin/env bash
# Execution VERIFY: PASS when config_delete_task.settings no longer exists. Prints PASS/FAIL;
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $exists = in_array("config_delete_task.settings", \Drupal::configFactory()->listAll("config_delete_task"), true);
  $ok = !$exists;
  print ($ok ? "PASS" : "FAIL") . " config_delete_task.settings=" . ($exists ? "present" : "gone") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
