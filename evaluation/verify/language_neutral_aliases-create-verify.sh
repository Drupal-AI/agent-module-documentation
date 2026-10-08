#!/usr/bin/env bash
# Execution VERIFY: PASS when a path_alias for /lna-task-source exists with alias
# /lna-task-alias and langcode 'und'. Reads the DB directly (avoids entity cache). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rows = \Drupal::database()->select("path_alias", "pa")
    ->fields("pa", ["alias", "langcode"])
    ->condition("path", "/lna-task-source")
    ->execute()->fetchAll();
  $ok = FALSE; $info = "missing";
  if ($rows) {
    $r = $rows[0];
    $ok = ($r->alias === "/lna-task-alias" && $r->langcode === "und");
    $info = "alias=" . $r->alias . " langcode=" . $r->langcode;
  }
  print ($ok ? "PASS" : "FAIL") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
