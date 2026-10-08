#!/usr/bin/env bash
# Execution VERIFY: PASS when version_mismatch contains key ccs_task_flow. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vm = \Drupal::config("cms_content_sync.developer")->get("version_mismatch");
  $ok = is_array($vm) && array_key_exists("ccs_task_flow", $vm);
  print ($ok ? "PASS" : "FAIL") . " keys=" . implode(",", is_array($vm) ? array_keys($vm) : []) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
