#!/usr/bin/env bash
# Execution VERIFY: PASS when the Hacked! hasher is hacked_include_line_endings. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $h = \Drupal::config("hacked.settings")->get("selected_file_hasher");
  print (($h === "hacked_include_line_endings") ? "PASS" : "FAIL") . " hasher=" . var_export($h, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
