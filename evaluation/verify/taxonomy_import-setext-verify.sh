#!/usr/bin/env bash
# Execution VERIFY: PASS when taxonomy_import.config file_extensions includes 'txt'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("taxonomy_import.config")->get("file_extensions");
  $ok = is_string($v) && in_array("txt", preg_split("/\s+/", trim($v)), TRUE);
  print ($ok ? "PASS" : "FAIL") . " file_extensions=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
