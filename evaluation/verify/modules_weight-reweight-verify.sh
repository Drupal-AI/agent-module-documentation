#!/usr/bin/env bash
# Execution VERIFY (modules_weight): PASS when the modules_weight module's weight in
# core.extension is 5. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("core.extension")->get("module")["modules_weight"] ?? NULL;
  $ok = ((int) $w === 5);
  print ($ok ? "PASS" : "FAIL") . " weight=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
