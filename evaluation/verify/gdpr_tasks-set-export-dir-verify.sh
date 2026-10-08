#!/usr/bin/env bash
# Execution VERIFY: PASS when gdpr_tasks.settings has a non-empty export_directory. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("gdpr_tasks.settings")->get("export_directory");
  $ok = (is_string($d) && $d !== "");
  print ($ok ? "PASS" : "FAIL") . " export_directory=" . var_export($d, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
