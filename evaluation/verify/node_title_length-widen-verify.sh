#!/usr/bin/env bash
# Execution VERIFY (node_title_length): PASS when the REAL node_field_data.title column can hold
# 700 chars (CHARACTER_MAXIMUM_LENGTH == 700), proving the agent widened the column (not just the
# runtime base-field max_length). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $len = \Drupal::database()->query(
    "SELECT CHARACTER_MAXIMUM_LENGTH FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :t AND COLUMN_NAME = :c",
    [":t" => "node_field_data", ":c" => "title"]
  )->fetchField();
  $ok = ((int) $len === 700);
  print ($ok ? "PASS" : "FAIL") . " node_field_data.title_length=" . var_export($len, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
