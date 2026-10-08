#!/usr/bin/env bash
# Execution VERIFY: PASS when the example_blocks module is installed/enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = \Drupal::moduleHandler()->moduleExists("example_blocks");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
