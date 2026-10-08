#!/usr/bin/env bash
# Execution VERIFY (taxonomy_term_title_length): PASS when the REAL taxonomy_term_field_data.name
# column can hold 620 chars (CHARACTER_MAXIMUM_LENGTH == 620), proving the agent widened the term
# name column. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $len = \Drupal::database()->query(
    "SELECT CHARACTER_MAXIMUM_LENGTH FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :t AND COLUMN_NAME = :c",
    [":t" => "taxonomy_term_field_data", ":c" => "name"]
  )->fetchField();
  $ok = ((int) $len === 620);
  print ($ok ? "PASS" : "FAIL") . " taxonomy_term_field_data.name_length=" . var_export($len, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
