#!/usr/bin/env bash
# Execution VERIFY: PASS when ECA model eca_cm_toggle is enabled (status TRUE). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("eca")->load("eca_cm_toggle");
  $st = $e ? $e->status() : NULL;
  $ok = ($e && $st === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($st, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
