#!/usr/bin/env bash
# Execution VERIFY: PASS when a fixed_block_content config entity fbc_task exists targeting the
# "basic" custom block bundle. Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("fixed_block_content")->load("fbc_task");
  $bundle = $e ? $e->getBlockContentBundle() : "none";
  $ok = ($e && $bundle === "basic");
  print ($ok ? "PASS" : "FAIL") . " entity=" . ($e ? "yes" : "no") . " bundle=" . $bundle . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
