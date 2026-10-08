#!/usr/bin/env bash
# Execution VERIFY: PASS when migrate_source_ui.settings file_temp_directory is set to
# 'private://migrate_source_ui_uploads'. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("migrate_source_ui.settings")->get("file_temp_directory");
  $ok = ($v === "private://migrate_source_ui_uploads");
  print ($ok ? "PASS" : "FAIL") . " file_temp_directory=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
