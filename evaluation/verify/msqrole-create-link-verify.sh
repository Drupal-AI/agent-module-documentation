#!/usr/bin/env bash
# Execution VERIFY: PASS when the msqrole.urls key/value store holds an entry whose roles include
# 'content_editor'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $all = \Drupal::keyValue("msqrole.urls")->getAll();
  $found = FALSE;
  foreach ($all as $e) {
    $roles = $e["roles"] ?? [];
    if (in_array("content_editor", array_values($roles), TRUE)) { $found = TRUE; break; }
  }
  print ($found ? "PASS" : "FAIL") . " entries=" . count($all) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
