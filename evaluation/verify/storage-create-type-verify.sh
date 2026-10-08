#!/usr/bin/env bash
# Execution VERIFY: PASS when a storage type (bundle) 'storage_task' exists. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal\storage\Entity\StorageType::load("storage_task");
  $ok = ($t !== NULL);
  print ($ok ? "PASS" : "FAIL") . " storage_task=" . ($ok ? "exists" : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
