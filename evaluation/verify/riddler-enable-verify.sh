#!/usr/bin/env bash
# Execution VERIFY: PASS when riddle ri_toggle exists and is enabled (status === TRUE).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("riddle")->load("ri_toggle");
  $ok = $e && $e->status() === TRUE;
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($e ? $e->status() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
