#!/usr/bin/env bash
# Execution VERIFY: PASS when the module's entity_update backup table is empty (what
# `drush upe --clean` / EntityUpdate::cleanupEntityBackup() does). exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = (int) \Drupal::database()->select("entity_update", "e")->countQuery()->execute()->fetchField();
  print ($n === 0 ? "PASS" : "FAIL") . " backup_rows=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
