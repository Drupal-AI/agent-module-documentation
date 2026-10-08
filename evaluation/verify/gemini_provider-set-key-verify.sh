#!/usr/bin/env bash
# Execution VERIFY: PASS when gemini_provider.settings api_key === "gemini_task_key". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("gemini_provider.settings")->get("api_key");
  print (($v === "gemini_task_key") ? "PASS" : "FAIL") . " api_key=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
