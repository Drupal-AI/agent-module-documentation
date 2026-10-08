#!/usr/bin/env bash
# Execution VERIFY: PASS when fixed_block_content fbc_ptask has protected === TRUE. Read-only. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("fixed_block_content")->load("fbc_ptask");
  $p = $e ? $e->isProtected() : NULL;
  $ok = ($e && $p === TRUE);
  print ($ok ? "PASS" : "FAIL") . " protected=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
