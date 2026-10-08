#!/usr/bin/env bash
# Execution VERIFY: PASS when 'svg' is in path_file.settings allowed_extensions. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ext = (string) \Drupal::config("path_file.settings")->get("allowed_extensions");
  $ok = in_array("svg", preg_split("/\s+/", trim($ext)), TRUE);
  print ($ok ? "PASS" : "FAIL") . " allowed_extensions=" . $ext . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
