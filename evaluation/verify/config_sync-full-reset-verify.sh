#!/usr/bin/env bash
# Execution VERIFY for "set config_sync update mode to Full reset (3)".
# PASS when state config_sync.update_mode === 3. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::state()->get("config_sync.update_mode");
  $ok = ((int) $m === 3);
  print ($ok ? "PASS" : "FAIL") . " update_mode=" . var_export($m, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
