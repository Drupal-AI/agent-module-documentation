#!/usr/bin/env bash
# Execution VERIFY: PASS when the file at public://bnrm_eval/restore.txt has been reconstructed on
# disk with the original bytes (proof FileEntityNormalizer::denormalize ran). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $real = \Drupal::service("file_system")->realpath("public://bnrm_eval/restore.txt");
  $ok = ($real && is_file($real) && file_get_contents($real) === "RESTORE-BYTES-88");
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool)($real && is_file($real)), TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
