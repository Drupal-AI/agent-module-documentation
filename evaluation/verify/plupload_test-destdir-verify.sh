#!/usr/bin/env bash
# Execution VERIFY: PASS when the demo destination directory public://plupload-test exists and
# is writable. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $dir = "public://plupload-test";
  $real = \Drupal::service("file_system")->realpath($dir);
  $ok = ($real && is_dir($real) && is_writable($real));
  print (($ok) ? "PASS" : "FAIL") . " dir=" . var_export($real, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
