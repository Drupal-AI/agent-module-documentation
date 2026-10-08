#!/usr/bin/env bash
# Execution VERIFY (title_length): PASS when the node title DB column has been re-widened to at
# least 500 (the module default) - i.e. the agent ran `drush title_length:update node` or called
# the service. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $l = (int) $db->query("SELECT CHARACTER_MAXIMUM_LENGTH FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :t AND COLUMN_NAME = :c", [":t"=>"node_field_data", ":c"=>"title"])->fetchField();
  print (($l >= 500) ? "PASS" : "FAIL") . " node_title_len=" . $l . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
