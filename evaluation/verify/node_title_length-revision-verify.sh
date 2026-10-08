#!/usr/bin/env bash
# Execution VERIFY (node_title_length): PASS when BOTH the node title column and its revision
# column are widened to 640 (node_title_length widens node_field_data.title AND
# node_field_revision.title). Reads the real schema; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $q = "SELECT CHARACTER_MAXIMUM_LENGTH FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :t AND COLUMN_NAME = :c";
  $data = (int) $db->query($q, [":t" => "node_field_data", ":c" => "title"])->fetchField();
  $rev  = (int) $db->query($q, [":t" => "node_field_revision", ":c" => "title"])->fetchField();
  $ok = ($data === 640 && $rev === 640);
  print ($ok ? "PASS" : "FAIL") . " data=" . $data . " revision=" . $rev . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
